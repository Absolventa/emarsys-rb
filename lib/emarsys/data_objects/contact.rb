module Emarsys
  class Contact < DataObject
    class << self
      def create(params = {})
        post "contact", params
      end

      def update(params = {})
        put "contact", params
      end
    end
  end
end