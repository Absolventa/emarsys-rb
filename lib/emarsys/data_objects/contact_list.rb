module Emarsys
  class ContactList < DataObject
    class << self
      def collection(params = {})
        get 'contactlist', params
      end

      def create(params = {})
        post "contactlist", params
      end

      # This cannot be an instance method, because the API does not allow to retrice a single resource. How crappy is that?
      def add_contacts(contact_list_id, key_id, external_ids = [])
        post "contactlist/#{contact_list_id}/add", {'key_id' => key_id, 'external_ids' => external_ids}
      end

      # same here
      def remove_contacts(contact_list_id, key_id, external_ids = [])
        post "contactlist/#{contact_list_id}/remove", {'key_id' => key_id, 'external_ids' => external_ids}
      end
    end
  end
end