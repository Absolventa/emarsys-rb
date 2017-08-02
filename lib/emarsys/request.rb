# frozen_string_literal: true
module Emarsys

  class Request
    attr_accessor :http_verb, :path, :params, :account

    def initialize(account, http_verb, path, params = {})
      self.path = path
      self.http_verb = http_verb.to_sym
      self.params = params
      self.account = account
    end

    def send_request
      args = {
        method: http_verb,
        url: emarsys_uri,
        headers: { content_type: :json, x_wsse: client.x_wsse_string }
      }

      if client.open_timeout
        args.merge!(open_timeout: client.open_timeout)
      end

      if client.read_timeout
        args.merge!(read_timeout: client.read_timeout)
      end

      if [:post, :put].include?(http_verb)
        args.merge!(payload: converted_params.to_json)
      end

      RestClient::Request.execute(args) do |response, request, result, &block|
        Emarsys::Response.new(response)
      end
    end

    def client
      Emarsys::Client.new(account)
    end

    def emarsys_uri
      [client.endpoint, @path].join('/')
    end

    def converted_params
      Emarsys::ParamsConverter.new(params).convert_to_ids
    end
  end

end
