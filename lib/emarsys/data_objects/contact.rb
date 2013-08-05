module Emarsys
  class Contact < DataObject
    class << self
      def create(key_id, key_value, params = {})
        post "contact", params.merge!({'key_id' => transform_key_id(key_id), transform_key_id(key_id) => key_value})
      end

      def update(key_id, key_value, params = {})
        put "contact", params.merge!({'key_id' => transform_key_id(key_id), transform_key_id(key_id) => key_value})
      end

      # Fake destroy - delete all attributes
      def destroy(key_id, key_value, params = {})
        update(key_id, key_value, params)
      end

      def transform_key_id(key_id)
        matching_attributes = Emarsys::FieldMapping::ATTRIBUTES.find{|elem| elem[:identifier] == key_id.to_s}
        matching_attributes.nil? ? key_id : matching_attributes[:id]
      end

    end
  end
end