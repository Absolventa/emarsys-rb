module Emarsys
  class Event < DataObject
    class << self
      def collection(params = {})
        get 'event', params
      end

      def trigger(event_id, external_id)
        post 'event', {:event_id => event_id, :external_id => external_id}
      end
    end
  end
end