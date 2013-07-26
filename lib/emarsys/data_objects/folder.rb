module Emarsys
  class Folder < DataObject
    class << self
      def collection(params = {})
        get 'folder', params
      end
    end
  end
end