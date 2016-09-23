#require 'hashie'

module Emarsys
  class DataObject
    class << self

      # Make a HTTP GET request
      #
      # @param method_name [String] The path, relative to Emarsys.api_endpoint
      # @param params [Hash] custom params hash
      # @return [Hash]
      def get(method_name, params)
        if params.empty?
          self.new.request 'get', method_name, params
        else
          self.new.request 'get', [method_name, parameterize_params(params)].join("/"), {}
        end
      end

      # Make a HTTP POST request
      #
      # @param method_name [String] The path, relative to Emarsys.api_endpoint
      # @param params [Hash] custom params hash
      # @return [Hash]
      def post(method_name, params)
        self.new.request 'post', method_name, params
      end

      # Make a HTTP PUT request
      #
      # @param method_name [String] The path, relative to Emarsys.api_endpoint
      # @param params [Hash] custom params hash
      # @return [Hash]
      def put(method_name, params)
        self.new.request 'put', method_name, params
      end

      # Make a HTTP DELETE request
      #
      # @param method_name [String] The path, relative to Emarsys.api_endpoint
      # @param params [Hash] custom params hash
      # @return [Hash]
      def delete(method_name, params)
        self.new.request 'delete', method_name, params
      end

      # Custom Parameterizer for Emarsys
      #
      # @param params [Hash] custom params hash
      # @return [String] {key1 => value1, key2 => value2 is returned as ?key1=value1&key2=value2
      def parameterize_params(params)
        '?' + params.map{|k, v| "#{url_encode(k)}=#{url_encode(v)}"}.join('&')
      end


      private

      # Encode params like Emarsys does
      def url_encode(param)
        ERB::Util.url_encode(param)
      end
    end

    # Make a HTTP request
    #
    # @param http_verb [String] Http method
    # @param method_name [String] The path, relative to Emarsys.api_endpoint
    # @param params [Hash] custom params hash
    # @return [Hash]
    def request(http_verb, method_name, params)
      response = Emarsys::Request.new(http_verb, method_name, params).send_request
      #hashiefy(response)
    end

    # TODO: Not finally evaluated. Is Hashie necessary? Maybe use "real Data Objects instead"?
    # def hashiefy(response)
    #   if response.is_a?(Array)
    #     response.map!{|elem| Hashie::Mash.new(elem) }
    #   elsif
    #     Hashie::Mash.new(response)
    #   else
    #     response
    #   end
    # end
  end
end
