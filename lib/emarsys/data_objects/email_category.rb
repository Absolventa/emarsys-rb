module Emarsys
  class EmailCategory < DataObject
    class << self
      def collection(params = {})
        get 'emailcategory', params
      end
    end
  end
end