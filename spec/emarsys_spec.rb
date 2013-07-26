require 'spec_helper'

describe Emarsys do

  describe ".configure" do
    [:api_endpoint, :api_username, :api_password].each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        Emarsys.configure do |config|
          config.send("#{key}=", key)
        end
        expect(Emarsys.instance_variable_get(:"@#{key}")).to eq key
      end
    end
  end

  describe ".api_endpoint getter" do
    it "returns specific url as default value" do
      Emarsys.api_endpoint = nil
      Emarsys.api_endpoint.should eq('https://suite5.emarsys.net/api/v2')
    end
  end
end