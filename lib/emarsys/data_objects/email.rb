module Emarsys
  class Email < DataObject
    class << self
      def collection(params = {})
        get 'email', params
      end

      def resource(id)
        get "email/#{id}", {}
      end

      def create(params = {})
        post "email", params
      end

      def launch
        # TODO
      end

      def preview(id, version = 'html')
        post "email/#{id}/preview", {:version => version}
      end

      def response_summary(id)
        get "email/#{id}/responsesummary", {}
      end
    end
  end
end