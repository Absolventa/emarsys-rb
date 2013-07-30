module Emarsys
  class Form < DataObject
    class << self
      def collection
        get 'form', {}
      end
    end
  end
end