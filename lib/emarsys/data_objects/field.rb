module Emarsys
  class Field < DataObject
    class << self
      def collection
        get 'field'
      end
    end
  end
end