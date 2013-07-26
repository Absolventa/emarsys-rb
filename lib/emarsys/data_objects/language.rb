module Emarsys
  class Language < DataObject
    class << self
      def collection
        get 'language', {}
      end
    end
  end
end