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
      # @return [Hash] Result data
      # @example
      #   Emarsys::Export.trigger(2, 3, 'test@example.com')
      def trigger(event_id, key_id, external_id)
        post "event/#{event_id}/trigger", {:key_id => key_id, :external_id => external_id}
      end
    end

  end
end