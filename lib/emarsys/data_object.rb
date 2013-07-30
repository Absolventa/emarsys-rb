module Emarsys
  class DataObject

    class << self
      def get(method_name, params)
        if params.empty?
          self.new.request 'get', method_name, params
        else
          self.new.request 'get', [method_name, parameterize_params(params)].join("/"), {}
        end
      end

      def post(method_name, params)
        self.new.request 'post', method_name, params
      end

      def put(method_name, params)
        self.new.request 'put', method_name, params
      end

      def delete(method_name, params)
        self.new.request 'delete', method_name, params
      end

      def parameterize_params(params)
        params.inject(""){|string, (k, v)| string << "#{k}=#{v}"; string << "&"; string}[0..-2]
      end
    end

    def request(http_verb, method_name, params)
      Emarsys::Request.new(http_verb, method_name, params).send_request
    end
  end
end