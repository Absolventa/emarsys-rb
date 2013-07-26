module Emarsys
  class ContactList < DataObject
    class << self
      def collection
        get 'contactlist'
      end
    end
  end
end