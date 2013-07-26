module Emarsys
  class File < DataObject
    class << self
      def collection
        get 'file'
      end
    end
  end
end