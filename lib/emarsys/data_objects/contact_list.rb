module Emarsys
  class ContactList < DataObject
    class << self
      def collection(params = {})
        get 'contactlist', params
      end

      def create(params = {})
        post "contactlist", params
      end
    end
  end
end