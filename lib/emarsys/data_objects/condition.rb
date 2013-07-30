module Emarsys
  class Condition < DataObject
    class << self
      def collection
        get 'condition', {}
      end
    end
  end
end