module Emarsys
  class Event < DataObject
    class << self
      def collection
        get 'event', {}
      end

      def trigger(event_id, key_id, external_id)
        post "event/#{event_id}/trigger", {:key_id => key_id, :external_id => external_id}
      end
    end
  end
end