module Emarsys
  class File < DataObject
    class << self
      def collection(params = {})
        get 'file', params
      end
    end
  end
end