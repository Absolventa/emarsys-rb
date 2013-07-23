module Emarsys
  class DataObject

    class << self
      def get(method_name)
        self.new.request method_name, 'get'
      end

      def post(method_name, params)
        self.new.request method_name, 'post', params
      end

      def put(method_name, params)
        self.new.request method_name, 'put', params
      end

      def delete(method_name, params)
        self.new.request method_name, 'delete', params
      end
    end

    def client
      Emarsys::Client.new
    end

    def request(method_name, http_verb)
      response = Emarsys::Request.new(client, method_name, http_verb).send_request
    end
  end
end