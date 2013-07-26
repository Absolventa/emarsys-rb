module Emarsys
  class Event < DataObject
    class << self
      def collection
        get 'event'
      end
    end
  end
end