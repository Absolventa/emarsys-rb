module Emarsys

  # Methods for the Contact API
  #
  #
  class Contact < DataObject
    class << self

      # Create a new contact. The given params are transformed to emarsys ids.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param key_value [Integer, String] value of interal id field
      # @param params [Hash] Contact information to create
      # @return [Hash] internal id of the contact
      # @example
      #   Emarsys::Contact.create('app_id', 23, {:firstname => "Jon", :lastname => "Doe"})
      #   Emarsys::Contact.create('3', 'john.doe@example.com', {'1' => "Jon", '2' => "Doe"})
      def create(key_id, key_value, params = {})
        transformed_key_id = transform_key_id(key_id)
        post "contact", params.merge!({'key_id' => transformed_key_id, transformed_key_id => key_value})
      end

      # Get the interal emarsys id of a contact. The given params are transformed to emarsys ids.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param key_value [Integer, String] value of interal id field
      # @return [Hash] internal emarsys id of the contact
      # @example
      #   Emarsys::Contact.emarsys_id('email', 'john.dow@example.com')
      #   Emarsys::Contact.emarsys_id(1, 'John')
      def emarsys_id(key_id, key_value)
        get "contact", {"#{transform_key_id(key_id).to_s}" => key_value}
      end

      # Update a contact. The given params are transformed to emarsys ids.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param key_value [Integer, String] value of interal id field
      # @param params [Hash] Contact information to update
      # @return [Hash] internal id of the contact
      # @example
      #   Emarsys::Contact.update('app_id', 23, {:firstname => "Jon", :lastname => "Doe"})
      #   Emarsys::Contact.update('3', 'john.doe@example.com', {'1' => "Jon", '2' => "Doe"})
      def update(key_id, key_value, params = {})
        transformed_key_id = transform_key_id(key_id)
        put "contact", params.merge!({'key_id' => transformed_key_id, transformed_key_id => key_value})
      end

      # Batch creation of contacts.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param params [Hash] Contact information of each new contact
      # @example
      #   Emarsys::Contact.create_batch(
      #     'email', {:app_id => 1, :firstname => "Jon", :lastname => "Doe"},
      #              {:app_id => 2, :firstname => "Jane", :lastname => "Doe"}
      #   )
      #
      # TODO params should be parameterized with field mappings
      def create_batch(key_id, params = [])
        post "contact", {'key_id' => transform_key_id(key_id), 'contacts' => params}
      end

      # Batch update of contacts.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param params [Hash] Contact information of each new contact
      # @example
      #   Emarsys::Contact.update_batch(
      #     'email', {:app_id => 1, :firstname => "Jon", :lastname => "Doe"},
      #              {:app_id => 2, :firstname => "Jane", :lastname => "Doe"}
      #   )
      #
      # TODO params should be parameterized with field mappings
      def update_batch(key_id, params = [])
        put "contact", {'key_id' => transform_key_id(key_id), 'contacts' => params}
      end

      # Get list of emails send to a contact
      #
      # @param contact_ids_array [array] Array of contact ids
      # @return [Hash] result data
      # @example
      #   Emarsys::Contact.contact_history([1,2,3]
      def contact_history(contact_ids_array)
        post "contact/getcontacthistory", {'contacts' => contact_ids_array}
      end

      # Get contact data by custom search
      #
      # @param key_id [Integer, String] Array of contact ids
      # @param key_values [array] Array of key field values
      # @param fields [array] requested fields. If empty, all are considered
      # @return [Hash] result data
      # @example
      #   Emarsys::Contact.search('3', ['john.doe@example.com'], [1,2,3]
      #
      # TODO transform fields to numeric fields
      def search(key_id, key_values = [], fields = [])
        post "contact/getdata", {'keyId' => key_id, 'keyValues' => key_values, 'fields' => fields}
      end

      # Exports the selected fields of contacts whoch registered in the specified time range
      #
      # @param params [hash] hash of parameters according to emarsys API
      # @return [Hash] result data
      # @example
      #   Emarsys::Contact.export_registrations(distribution_method: 'local', time_range: ["2013-01-01","2013-12-31"], contact_fields: [1,2,3])
      def export_registrations(params = {})
        post "contact/getregistrations", params
      end

      # @private
      def transform_key_id(key_id)
        matching_attributes = Emarsys::FieldMapping::ATTRIBUTES.find{|elem| elem[:identifier] == key_id.to_s}
        matching_attributes.nil? ? key_id : matching_attributes[:id]
      end

    end
  end
end
