module Emarsys
  class Condition < DataObject
    class << self
      def collection(params = {})
        get 'condition', params
      end
    end
  end
end