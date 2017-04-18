# frozen_string_literal: true
module Emarsys

  class Request
    attr_accessor :http_verb, :path, :params, :account

    def initialize(account, http_verb, path, params = {})
      self.path = path
      self.http_verb = http_verb
      self.params = params
      self.account = account
    end

    def send_request
      case http_verb.to_sym
      when :post
        RestClient.post(emarsys_uri, converted_params.to_json, :content_type => :json, :x_wsse => client.x_wsse_string) do |response, request, result, &block|
          Emarsys::Response.new(response)
        end
      when :put
        RestClient.put emarsys_uri, converted_params.to_json, :content_type => :json, :x_wsse => client.x_wsse_string do |response, request, result, &block|
          Emarsys::Response.new(response)
        end
      when :delete
        RestClient.delete(emarsys_uri, :content_type => :json, :x_wsse => client.x_wsse_string) do |response, request, result, &block|
          Emarsys::Response.new(response)
        end
      else
        RestClient.get(emarsys_uri, :content_type => :json, :x_wsse => client.x_wsse_string) do |response, request, result, &block|
          Emarsys::Response.new(response)
        end
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
