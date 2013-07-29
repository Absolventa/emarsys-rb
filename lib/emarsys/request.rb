module Emarsys

  class Request
    attr_accessor :client, :path, :http_verb, :params

    def initialize(client, path, http_verb, params = {})
      self.client = client
      self.path = path
      self.http_verb = http_verb
      self.params = params
    end

    def send_request
      case http_verb.to_sym
      when :post
        RestClient.post(emarsys_uri, converted_params.to_json, :content_type => :json, :x_wsse => client.x_wsse_string) do |response, request, result, &block|
          Emarsys::Response.new(response).result
        end
      when :put
        RestClient.put emarsys_uri, converted_params.to_json, :content_type => :json, :x_wsse => client.x_wsse_string do |response, request, result, &block|
          Emarsys::Response.new(response).result
        end
      when :delete
        RestClient.delete(emarsys_uri, :content_type => :json, :x_wsse => client.x_wsse_string) do |response, request, result, &block|
          Emarsys::Response.new(response).result
        end
      else
        RestClient.get(emarsys_uri, :content_type => :json, :x_wsse => client.x_wsse_string) do |response, request, result, &block|
          Emarsys::Response.new(response).result
        end
      end
    end

    def emarsys_uri
      [Emarsys.api_endpoint, @path].join('/')
    end

    def converted_params
      Emarsys::ParamsConverter.new(params).convert_to_ids
    end

  end

end