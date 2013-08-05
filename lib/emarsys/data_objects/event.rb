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

      def trigger(event_id, key_id, external_id)
        post "event/#{event_id}/trigger", {:key_id => key_id, :external_id => external_id}
      end
    end

  end
end