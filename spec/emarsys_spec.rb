require 'spec_helper'

describe Emarsys do

  describe ".configure" do
    [:api_endpoint, :api_username, :api_password].each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        Emarsys.configure do |config|
          config.send("#{key}=", key)
        end
        expect(Emarsys::Configuration.for(nil).__send__(key)).to eq key
      end
    end
  end

end
