require 'spec_helper'

describe Emarsys::Client do

  describe 'configs for username and password' do
    it 'inherits username from module' do
      expect(Emarsys::Client.new.username).to eq("my_username")
    end

    it 'inherits password from module' do
      expect(Emarsys::Client.new.password).to eq("my_password")
    end

    context 'missing values' do
      before do
        Emarsys.configure do |config|
          config.api_username = nil
          config.api_password = nil
        end
      end
      it 'raises error if api_username is not set' do
        expect{Emarsys::Client.new.username}.to raise_error(ArgumentError, 'api_username is not set')
      end

      it 'raises error if api_password is not set' do
        expect{Emarsys::Client.new.password}.to raise_error(ArgumentError, 'api_password is not set')
      end
    end
  end

  context 'client authentication' do
    describe '#x_wsse_string' do
      it 'builds x_wsse_string with specific format' do
        allow_any_instance_of(Emarsys::Client).to receive(:username).and_return("my_username")
        allow_any_instance_of(Emarsys::Client).to receive(:header_password_digest).and_return("12345689")
        allow_any_instance_of(Emarsys::Client).to receive(:header_nonce).and_return("some_header_nonce")
        allow_any_instance_of(Emarsys::Client).to receive(:header_created).and_return("2013-01-01")
        expect(Emarsys::Client.new.x_wsse_string).to eq(
          'UsernameToken Username="my_username", PasswordDigest="12345689", Nonce="some_header_nonce", Created="2013-01-01"'
        )
      end
    end

    describe '#header_password_digest' do
      before :each do
        allow_any_instance_of(Emarsys::Client).to receive(:calculated_digest).and_return("something")
      end

      it 'encodes string with Base64' do
        expect(Base64).to receive(:encode64).with("something").and_return("something_base64_encoded")
        Emarsys::Client.new.header_password_digest
      end

      it 'strips of \n character' do
        expect(Base64).to receive(:encode64).with("something").and_return("something_base64_encoded\n")
        expect(Emarsys::Client.new.header_password_digest).to eq("something_base64_encoded")
      end
    end

    describe '#header_nonce' do
      it 'uses 16 random bytes to generate a 32 char hex string' do
        expect(Emarsys::Client.new.header_nonce).to match(/^[0-9a-f]{32}$/i)
      end

      it 'only creates the nonce once' do
        client = Emarsys::Client.new
        nonce = client.header_nonce
        expect(client.header_nonce).to eq nonce
      end

      describe 'in a forked environment' do
        it 'will not break apart' do
          fork do
            client = Emarsys::Client.new
            nonce = client.header_nonce
            expect(client.header_nonce).to eq nonce
          end
        end
      end if RUBY_ENGINE == 'ruby'
    end

    describe '#header_created' do
      it 'uses current timestamp format' do
        expect(Emarsys::Client.new.header_created).to eq(Time.now.utc.iso8601)
      end
    end

    describe '#calculated_digest' do
      it 'runs sha1 on header_nonce + header_created + password' do
        allow_any_instance_of(Emarsys::Client).to receive(:header_nonce).and_return("some_header_nonce")
        allow_any_instance_of(Emarsys::Client).to receive(:header_created).and_return("12345689")
        allow_any_instance_of(Emarsys::Client).to receive(:password).and_return("my_password")
        expect(Digest::SHA1).to receive(:hexdigest).with("some_header_nonce12345689my_password")
        Emarsys::Client.new.calculated_digest
      end
    end

  end

end
