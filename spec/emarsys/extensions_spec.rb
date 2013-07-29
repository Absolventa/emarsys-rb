require 'spec_helper'

describe Hash do

  context 'extensions on Hash' do

    describe '#stringfy_keys' do
      it "add stringify_keys method to Hash" do
        expect(Hash.new).to respond_to(:stringify_keys)
      end

      it "converts symbol-keys into strings" do
        hash = {:a => 1, :b => 2}
        expect(hash.stringify_keys).to eq({'a' => 1, "b" => 2})
      end

      it "does not touch string-keys" do
        hash = {:a => 1, 'b' => 2}
        expect(hash.stringify_keys).to eq({'a' => 1, "b" => 2})
      end
    end
  end

end