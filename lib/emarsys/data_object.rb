## frozen_string_literal: true
#require 'hashie'

module Emarsys
  class DataObject
    class << self

      # Make a HTTP GET request
      #
      # @param account [Symbol] Configuration account to use
      # @param method_name [String] The path, relative to Emarsys.api_endpoint
      # @param params [Hash] custom params hash
      # @return [Hash]
      def get(account, method_name, params)
        if params.empty?
          self.new.request account, 'get', method_name, params
        else
          self.new.request account, 'get', [method_name, parameterize_params(params)].join("/"), {}
        end
      end

      # Make a HTTP POST request
      #
      # @param account [Symbol] Configuration account to use
      # @param method_name [String] The path, relative to Emarsys.api_endpoint
      # @param params [Hash] custom params hash
      # @return [Hash]
      def post(account, method_name, params)
        self.new.request account, 'post', method_name, params
      end

      # Make a HTTP PUT request
      #
      # @param account [Symbol] Configuration account to use
      # @param method_name [String] The path, relative to Emarsys.api_endpoint
      # @param params [Hash] custom params hash
      # @return [Hash]
      def put(account, method_name, params)
        self.new.request account, 'put', method_name, params
      end

      # Make a HTTP DELETE request
      #
      # @param account [Symbol] Configuration account to use
      # @param method_name [String] The path, relative to Emarsys.api_endpoint
      # @param params [Hash] custom params hash
      # @return [Hash]
      def delete(account, method_name, params)
        self.new.request account, 'delete', method_name, params
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
    # @param account [Symbol] Configuration account to use
    # @param http_verb [String] Http method
    # @param method_name [String] The path, relative to Emarsys.api_endpoint
    # @param params [Hash] custom params hash
    # @return [Hash]
    def request(account, http_verb, method_name, params)
      response = Emarsys::Request.new(account, http_verb, method_name, params).send_request
    end
  end
end
