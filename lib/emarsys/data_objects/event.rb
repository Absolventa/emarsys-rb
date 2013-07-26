module Emarsys
  class Event < DataObject
    class << self
      def collection(params = {})
        get 'event', params
      end
    end
  end
end