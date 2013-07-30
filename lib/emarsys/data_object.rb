module Emarsys
  class DataObject

    class << self
      def get(method_name, params)
        if params.empty?
          self.new.request method_name, 'get', params
        else
          self.new.request [method_name, parameterize_params(params)].join("/"), 'get', {}
        end
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

      def parameterize_params(params)
        params.inject(""){|string, (k, v)| string << "#{k}=#{v}"; string << "&"; string}[0..-2]
      end
    end

    def request(method_name, http_verb, params)
      Emarsys::Request.new(method_name, http_verb, params).send_request
    end
  end
end