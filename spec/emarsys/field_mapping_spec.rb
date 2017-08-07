require 'spec_helper'

describe Emarsys::FieldMapping do

  it "defines constant ATTRBUTES " do
    expect(Emarsys::FieldMapping.attributes).to be_a(Array)
  end

  it "defines constant ATTRBUTES as an array if hashes" do
    expect(Emarsys::FieldMapping.attributes).to be_a(Array)
    Emarsys::FieldMapping.attributes.map{|elem| expect(elem).to be_a(Hash) }
  end

end
