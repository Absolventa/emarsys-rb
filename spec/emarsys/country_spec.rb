require 'spec_helper'

describe Emarsys::Country do

  describe 'from_iso' do
    it 'maps ISO-3166-1 alpha-2 country code to equivalent Emarsys internal country ID' do
      expect(Emarsys::Country.from_iso('AF')).to eq( { id: 1, name: 'Afghanistan'} )
    end

    it 'supports passing ISO country code as a symbol' do
      expect(Emarsys::Country.from_iso(:AF)).to eq( { id: 1, name: 'Afghanistan'} )
    end

    it 'ignores case of the ISO country code' do
      expect(Emarsys::Country.from_iso('aF')).to eq( { id: 1, name: 'Afghanistan'} )
    end

    it 'returns nil for an unknown/invalid code' do
      expect(Emarsys::Country.from_iso('XY')).to eq nil
    end
  end
end
