module Emarsys
  class Folder < DataObject
    class << self
      def collection
        get 'folder'
      end
    end
  end
end