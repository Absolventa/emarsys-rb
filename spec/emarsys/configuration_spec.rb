require 'spec_helper'

describe Emarsys::Configuration do

  describe ".configure" do
    [:api_endpoint, :api_username, :api_password].each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        Emarsys::Configuration.configure(account: :foo) do |config|
          config.send("#{key}=", key)
        end
        expect(Emarsys::Configuration.for(:foo).__send__(key)).to eq key
      end
    end
  end

  describe ".api_endpoint getter" do
    it "returns specific url as default value" do
      Emarsys.configure { |c| c.api_endpoint = nil }
      expect(Emarsys::Configuration.for(nil).api_endpoint).to eq('https://api.emarsys.net/api/v2')
    end
  end
end
