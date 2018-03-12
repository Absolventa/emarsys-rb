require 'spec_helper'

describe Emarsys::ParamsConverter do
  let(:converter) { Emarsys::ParamsConverter.new({}) }

  before :each do
    attributes = [
      {:id => 0,   :identifier => 'interests', :name => 'Interests'},
      {:id => 1,   :identifier => 'first_name', :name => 'First Name'},
      {:id => 2,   :identifier => 'last_name',  :name => 'Last Name'},
    ]

    allow(Emarsys::FieldMapping).to receive(:attributes).and_return(
      attributes
    )
  end

  describe 'with attributes' do
    it 'sets params attribute on initialize' do
      params = {1 => 'Jane', 2 => 'Doe'}
      params_converter = Emarsys::ParamsConverter.new(params)
      expect(params_converter.params).to eq(params)
    end
  end

  context 'converting id-based hashes into string keys' do
    it 'converts all findable string keys' do
      converter.params = {'first_name' => 'Jane', 'last_name' => 'Doe'}
      expect(converter.convert_to_ids).to eq({1 => 'Jane', 2 => 'Doe'})
    end

    it 'does not convert non-findable keys' do
      converter.params = {'first_name' => 'Jane', 'last_name' => 'Doe', 'something' => 'abc'}
      expect(converter.convert_to_ids).to eq({1 => 'Jane', 2 => 'Doe', 'something' => 'abc'})
    end
  end

  context 'converting string-based hashes into id keys' do
    it 'converts all findable keys' do
      converter.params = {1 => 'Jane', 2 => 'Doe'}
      expect(converter.convert_to_identifiers).to eq({'first_name' => 'Jane', 'last_name' => 'Doe'})
    end

    it 'does not convert 0-key (since ''.to_i, which is 0, is a relevant field at emarsys)' do
      converter.params = {0 => 'Yeah', 1 => 'Jane', 2 => 'Doe'}
      expect(converter.convert_to_identifiers).to eq({0 => 'Yeah', 'first_name' => 'Jane', 'last_name' => 'Doe'})
    end

    it 'does not convert non-findable keys' do
      converter.params = {1 => 'Jane', 2 => 'Doe', 4 => 'something'}
      expect(converter.convert_to_identifiers).to eq({'first_name' => 'Jane', 'last_name' => 'Doe', 4 => 'something'})
    end
  end

end
