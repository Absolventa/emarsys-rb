module Emarsys
  class Field < DataObject
    class << self
      def collection(params = {})
        get 'field', params
      end
    end
  end
end