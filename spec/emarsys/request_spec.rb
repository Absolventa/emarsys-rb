require 'spec_helper'

describe Emarsys::Request do
  let(:client) { Emarsys::Client.new }
  let(:request) { Emarsys::Request.new('get', 'some-path', {:a => 1}) }

  describe '#initialize' do
    it 'sets client, path, http_verb and params attributes on initialize' do
      expect(request.http_verb).to eq('get')
      expect(request.path).to eq("some-path")
      expect(request.params).to eq({:a => 1})
    end
  end

  describe '#client' do
    it "provides a simple client accessor method" do
      expect(request.client).to be_a(Emarsys::Client)
    end
  end

  describe '#emarsys_uri' do
    it 'concats api_endpoint with path' do
      expect(request.emarsys_uri).to eq("https://api.emarsys.net/api/v2/some-path")
    end
  end

end
