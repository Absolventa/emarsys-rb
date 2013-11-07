module Emarsys

  # Methods for the Event API
  #
  #
  class Event < DataObject

    class << self

      # List events
      #
      # @return [Hash] List of events
      # @example
      #   Emarsys::Event.collection
      def collection
        get 'event', {}
      end

      # Trigger an external event
      #
      # @param event_id [Integer, String] The internal emarsys id
      # @param key_id [Integer, String] The identifer of the key field (e.g. 3 for 'email')
      # @param external_id [String] The id of the given filed specified with key_id (e.g. 'test@example.com')
      # @option data [Hash] data hash for transactional mails
      # @return [Hash] Result data
      # @example
      #   Emarsys::Event.trigger(2, 3, 'test@example.com')
      #   Emarsys::Event.trigger(2, 'user_id', 57687, {:global => {:name => "Special Name"}})
      def trigger(event_id, key_id, external_id, data = {})
        transformed_key_id = transform_key_id(key_id)
        params = {:key_id => transformed_key_id, :external_id => external_id}
        params.merge!(:data => data) if not data.empty?
        post "event/#{event_id}/trigger", params
      end

      # @private
      def transform_key_id(key_id)
        matching_attributes = Emarsys::FieldMapping::ATTRIBUTES.find{|elem| elem[:identifier] == key_id.to_s}
        matching_attributes.nil? ? key_id : matching_attributes[:id]
      end
    end

  end
end