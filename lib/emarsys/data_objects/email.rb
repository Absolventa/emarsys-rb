module Emarsys
  class Email < DataObject
    class << self
      def collection(params = {})
        get 'email', params
      end

      def resource(id)
        get "email/#{id}"
      end

      def create(params = {})
        post "email", params
      end

      def launch
        # TODO
      end
    end
  end
end