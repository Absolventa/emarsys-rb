module Emarsys
  class EmailCategory < DataObject
    class << self
      def collection
        get 'emailcategory'
      end
    end
  end
end