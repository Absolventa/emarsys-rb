module Emarsys
  class Source < DataObject
    class << self
      def collection
        get 'source'
      end
    end
  end
end