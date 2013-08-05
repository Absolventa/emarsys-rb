module Emarsys

  # Methods for the Contact API
  #
  #
  class Contact < DataObject

    class << self
      def create(key_id, key_value, params = {})
        post "contact", params.merge!({'key_id' => transform_key_id(key_id), transform_key_id(key_id) => key_value})
      end

      def emarsys_id(key_id, key_value)
        get "contact/#{key_id.to_s}=#{key_value.to_s}", {}
      end

      def update(key_id, key_value, params = {})
        put "contact", params.merge!({'key_id' => transform_key_id(key_id), transform_key_id(key_id) => key_value})
      end

      # TODO params should be parameterized with field mappings
      def create_batch(key_id, params = [])
        post "contact", {'key_id' => transform_key_id(key_id), 'contacts' => params}
      end

      # TODO params should be parameterized with field mappings
      def update_batch(key_id, params = [])
        put "contact", {'key_id' => transform_key_id(key_id), 'contacts' => params}
      end

      def contact_history(contact_ids_array)
        post "contact/getcontacthistory", {'contacts' => contact_ids_array}
      end

      # TODO transform fields to numeric fields
      def search(key_id, key_values = [], fields = [])
        post "contact/getdata", {'keyId' => key_id, 'keyValues' => key_values, 'fields' => fields}
      end

      def transform_key_id(key_id)
        matching_attributes = Emarsys::FieldMapping::ATTRIBUTES.find{|elem| elem[:identifier] == key_id.to_s}
        matching_attributes.nil? ? key_id : matching_attributes[:id]
      end

    end

  end

end