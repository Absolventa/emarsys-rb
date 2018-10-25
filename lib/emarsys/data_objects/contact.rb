# frozen_string_literal: true
module Emarsys

  # Methods for the Contact API
  #
  #
  class Contact < DataObject
    class << self

      # Create a new contact. The given params are transformed to emarsys ids.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param key_value [Integer, String] value of internal id field
      # @param params [Hash] Contact information to create
      # @return [Hash] internal id of the contact
      # @example
      #   Emarsys::Contact.create('app_id', 23, {:firstname => "Jon", :lastname => "Doe"})
      #   Emarsys::Contact.create('3', 'john.doe@example.com', {'1' => "Jon", '2' => "Doe"})
      def create(key_id:, key_value:, params: {}, account: nil)
        transformed_key_id = transform_key_id(key_id)
        post account, "contact", params.merge!({'key_id' => transformed_key_id, transformed_key_id => key_value})
      end

      # Get the internal emarsys id of a contact. The given params are transformed to emarsys ids.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param key_value [Integer, String] value of internal id field
      # @return [Hash] internal emarsys id of the contact
      # @example
      #   Emarsys::Contact.emarsys_id('email', 'john.dow@example.com')
      #   Emarsys::Contact.emarsys_id(1, 'John')
      def emarsys_id(key_id:, key_value:, account: nil)
        get account, "contact", {"#{transform_key_id(key_id).to_s}" => key_value}
      end

      # Update a contact. The given params are transformed to emarsys ids.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param key_value [Integer, String] value of internal id field
      # @param params [Hash] Contact information to update
      # @param create_if_not_exists [Boolean] Whether to create contact if it does not exist
      # @return [Hash] internal id of the contact
      # @example
      #   Emarsys::Contact.update('app_id', 23, {:firstname => "Jon", :lastname => "Doe"})
      #   Emarsys::Contact.update('3', 'john.doe@example.com', {'1' => "Jon", '2' => "Doe"}, true)
      def update(key_id:, key_value:, params: {}, create_if_not_exists: false, account: nil)
        path = "contact#{create_if_not_exists ? '/?create_if_not_exists=1' : ''}"
        transformed_key_id = transform_key_id(key_id)
        put account, path, params.merge!({'key_id' => transformed_key_id, transformed_key_id => key_value})
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
      def create_batch(key_id:, params: [], account: nil)
        post account, "contact", {'key_id' => transform_key_id(key_id), 'contacts' => batch_params(params)}
      end

      # Batch update of contacts.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param params [Hash] Contact information of each new contact
      # @param create_if_not_exists [Boolean] Whether to create non-existing contacts
      # @example
      #   Emarsys::Contact.update_batch(
      #     'email',
      #     [{:email => "john@example.com", :firstname => "Jon", :lastname => "Doe"},
      #      {:email => "jane@example.com", :firstname => "Jane", :lastname => "Doe"}],
      #     true
      #   )
      #
      def update_batch(key_id:, params: [], create_if_not_exists: false, account: nil)
        path = "contact#{create_if_not_exists ? '/?create_if_not_exists=1' : ''}"
        put account, path, {'key_id' => transform_key_id(key_id), 'contacts' => batch_params(params)}
      end

      # Delete a contact. The given params are transformed to emarsys ids.
      #
      # @param key_id [Integer, String] internal id of key field
      # @param key_value [Integer, String] value of internal id field
      # @return [Hash]
      # @example
      #   Emarsys::Contact.update('app_id', 23, {:firstname => "Jon", :lastname => "Doe"})
      #   Emarsys::Contact.update('3', 'john.doe@example.com', {'1' => "Jon", '2' => "Doe"}, true)
      def delete(key_id:, key_value:, account: nil)
        path = "contact/delete"
        transformed_key_id = transform_key_id(key_id)
        post account, path, {'key_id' => transformed_key_id, transformed_key_id => key_value}
      end

      # Get list of emails send to a contact
      #
      # @param contacts [array] Array of contact ids
      # @return [Hash] result data
      # @example
      #   Emarsys::Contact.contact_history([1,2,3]
      def contact_history(contacts:, account: nil)
        post account, "contact/getcontacthistory", {'contacts' => contacts}
      end

      # Get contact data by custom search
      #
      # @param key_id [Integer, String] Array of contact ids
      # @param key_values [array] Array of key field values
      # @param fields [array] requested fields. If empty, all are considered
      # @return [Hash] result data
      # @example
      #   Emarsys::Contact.search('3', ['john.doe@example.com'], [1,2,3])
      #
      # TODO transform fields to numeric fields
      def search(key_id:, key_values:, fields: [], account: nil)
        post account, "contact/getdata", {'keyId' => key_id, 'keyValues' => key_values, 'fields' => fields}
      end

      # Query contacts by custom
      #
      # @param return_value [Integer, String] Value of internal id field
      # @param account [String] The account to use
      # @param opts [Mixed] Further symbols to pass down to the request
      # @return [Hash] result data
      # @example
      #   # Get all emails from the emarsys account
      #   Emarsys::Contact.query(return_value: 'email')
      #   # Get the ID of the account with a specific email
      #   Emarsys::Contact.query(key_id: '_email', key_value: 'john.doe@example.com', return_value: 'email')
      #   Emarsys::Contact.query(key_id: 3, key_value: 'jane.doe@example.com', return_value: 'email')
      def query(return_value:, account: nil, **opts)
        if opts.key?(:key_id) && opts.key?(:key_value)
          id, value = [opts.delete(:key_id), opts.delete(:key_value)]
          opts["#{transform_key_id(id).to_s}"] = value
        end

        opts = opts.each_with_object({}) do |(key, val), memo|
          memo[key.to_s] = val
        end

        get account, 'contact/query', opts.merge('return' => return_value)
      end

      # Exports the selected fields of contacts whoch registered in the specified time range
      #
      # @param params [hash] hash of parameters according to emarsys API
      # @return [Hash] result data
      # @example
      #   Emarsys::Contact.export_registrations(distribution_method: 'local', time_range: ["2013-01-01","2013-12-31"], contact_fields: [1,2,3])
      def export_registrations(distribution_method:, time_range:, contact_fields:, account: nil)
        post account, "contact/getregistrations", {
          distribution_method: distribution_method,
          time_range: time_range,
          contact_fields: contact_fields
        }
      end

      # @private
      def transform_key_id(key_id)
        matching_attributes = Emarsys::FieldMapping.attributes.find{|elem| elem[:identifier] == key_id.to_s}
        matching_attributes.nil? ? key_id : matching_attributes[:id]
      end

      # @private
      def batch_params(params = [])
        params.map { |p| Emarsys::ParamsConverter.new(p).convert_to_ids }
      end

    end
  end
end
