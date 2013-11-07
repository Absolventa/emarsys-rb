module Emarsys

  # Methods for the ContactList API
  #
  #
  class ContactList < DataObject
    class << self

      # List contact lists
      #
      # @return [Hash] List of contact_lists
      # @example
      #   Emarsys::ContactList.collection
      def collection
        get 'contactlist', {}
      end

      # Create a new contact list
      #
      # @param params [Hash] Contact list information to create
      # @option params [String] :name Name of the list
      # @option params [String] :description Detailed description of the list

      # @return [Hash] internal id of the contact list
      # @example
      #   Emarsys::ContactList.create(key_id: "3", name: 'Test-Liste', description: 'Something')
      def create(params = {})
        post "contactlist", params
      end

      # Add a contacts to a specific contact list
      #
      # This cannot be an instance method, because the API does not allow to retrieve a single resource. How crappy is that?
      def add_contacts(contact_list_id, key_id, external_ids = [])
        post "contactlist/#{contact_list_id}/add", {'key_id' => key_id, 'external_ids' => external_ids}
      end

      # Remove contacts from a specific contact list
      #
      # This cannot be an instance method, because the API does not allow to retrieve a single resource. How crappy is that?
      def remove_contacts(contact_list_id, key_id, external_ids = [])
        post "contactlist/#{contact_list_id}/remove", {'key_id' => key_id, 'external_ids' => external_ids}
      end

    end
  end
end