module Emarsys
  class Field < DataObject
    class << self
      def collection(params = {})
        get 'field', params
      end

      def choice(id)
        get "field/#{id}/choice", {}
      end
    end
  end
end