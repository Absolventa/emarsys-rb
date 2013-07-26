module Emarsys
  class Segment < DataObject
    class << self
      def collection
        get 'filter'
      end
    end
  end
end