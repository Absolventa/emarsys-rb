require 'spec_helper'

describe Emarsys::FieldMapping do

  it "defines attributes " do
    expect(Emarsys::FieldMapping.attributes).to be_a(Array)
  end

  it "defines attributes as an array of hashes" do
    expect(Emarsys::FieldMapping.attributes).to be_a(Array)
    Emarsys::FieldMapping.attributes.map{|elem| expect(elem).to be_a(Hash) }
  end

  it "merges attributes" do
    attributes = [
      {:id => 101,   :identifier => 'foo', :name => 'Foo'},
      {:id => 102,   :identifier => 'bar', :name => 'Bar'}
    ]
    Emarsys::FieldMapping.add_attributes(attributes)
    expect(Emarsys::FieldMapping.attributes).to include(attributes[0], attributes[1])
  end

  it "redefines attributes" do
    attributes = [
      {:id => 101,   :identifier => 'foo', :name => 'Foo'},
      {:id => 102,   :identifier => 'bar', :name => 'Bar'}
    ]
    Emarsys::FieldMapping.set_attributes(attributes)
    expect(Emarsys::FieldMapping.attributes).to match_array(attributes)
  end

end
