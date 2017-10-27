require 'spec_helper'

describe Emarsys::Field do
  describe ".collection" do
    it "requests all fields" do
      expect(
        stub_get("field") { Emarsys::Field.collection }
      ).to have_been_requested.once
    end

    it "requests all fields with translate parameter" do
      expect(
        stub_get("field/translate/en") { Emarsys::Field.collection(translate: 'en') }
      ).to have_been_requested.once
    end
  end

  describe ".choice" do
    it "requests the choice options of a field" do
      expect(
        stub_get("field/1/choice") { Emarsys::Field.choice(1) }
      ).to have_been_requested.once
    end
  end

  describe '.create' do
    it 'creates a new custom field' do
      expect(
        stub_post('field') do
          Emarsys::Field.create(name: 'New field', application_type: 'shorttext')
        end
      ).to have_been_requested.once
    end
  end
end
