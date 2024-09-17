require 'spec_helper'

describe Emarsys::FieldMapping do

  it "defines constant ATTRBUTES " do
    expect(Emarsys::FieldMapping::ATTRIBUTES).to be_a(Array)
  end

  it "defines constant ATTRBUTES as an array if hashes" do
    expect(Emarsys::FieldMapping::ATTRIBUTES).to be_a(Array)
    expect(Emarsys::FieldMapping::ATTRIBUTES).to all(be_a(Hash))
  end

  describe '.attributes' do
    describe 'backward-compatibility' do
      it 'defines an array of hashes' do
        expect(Emarsys::FieldMapping.attributes).to be_a(Array)
        expect(Emarsys::FieldMapping.attributes).to all(be_a(Hash))
      end

      it 'returns the content of ATTRIBUTES by default' do
        attributes_stub = double('ATTRIBUTES')
        stub_const('Emarsys::FieldMapping::ATTRIBUTES', attributes_stub)

        expect(Emarsys::FieldMapping.attributes).to eq(attributes_stub)
      end
    end
  end

  describe '.set_attributes' do
    it 'redefines attributes' do
      attributes = [
        {:id => 101,   :identifier => 'foo', :name => 'Foo'},
        {:id => 102,   :identifier => 'bar', :name => 'Bar'}
      ]

      Emarsys::FieldMapping.set_attributes(attributes)
      expect(Emarsys::FieldMapping.attributes).to match_array(attributes)
    end

    it 'turns off use of default-predefined ATTRIBUTES' do
      attributes_stub = double('ATTRIBUTES')
      allow(attributes_stub).to receive(:<<).and_return(attributes_stub)

      stub_const('Emarsys::FieldMapping::ATTRIBUTES', attributes_stub)

      mapping_to_be_added = {
        id: 2000, identifier: 'foo', name: 'Foo'
      }

      attributes = [
        {:id => 101,   :identifier => 'foo', :name => 'Foo'},
        {:id => 102,   :identifier => 'bar', :name => 'Bar'}
      ]

      Emarsys::FieldMapping.set_attributes(attributes)
      Emarsys::FieldMapping::ATTRIBUTES << mapping_to_be_added

      expect(Emarsys::FieldMapping.attributes).to match_array(attributes)
    end
  end

  describe '.add_attributes' do
    it "merges attributes" do
      attributes = [
        {:id => 101,   :identifier => 'foo', :name => 'Foo'},
        {:id => 102,   :identifier => 'bar', :name => 'Bar'}
      ]

      stub_const('Emarsys::FieldMapping::ATTRIBUTES', attributes)

      mapping_to_be_added = {
        id: 2000, identifier: 'baz', name: 'Baz'
      }

      Emarsys::FieldMapping.add_attributes(mapping_to_be_added)
      expect(Emarsys::FieldMapping.attributes).to include(attributes[0], attributes[1], mapping_to_be_added)
    end
  end

end
