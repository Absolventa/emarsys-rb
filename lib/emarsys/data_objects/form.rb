module Emarsys
  class Form < DataObject
    class << self
      def collection(params = {})
        get 'form', params
      end
    end
  end
end