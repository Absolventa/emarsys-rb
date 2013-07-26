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
      perform_request(emarsys_uri)
    end

    def emarsys_uri
      [Emarsys.api_endpoint, @path].join('/')
    end

    def converted_params
      Emarsys::ParamsConverter.new(params).convert_to_ids
    end

    private

    def perform_request(uri)
      case http_verb.to_sym
      when :post
        RestClient.post(uri, converted_params.to_json, :content_type => :json, :x_wsse => client.x_wsse_string) do |response, request, result, &block|
          Emarsys::Response.new(response).result
        end
      when :put
        RestClient.put uri, converted_params.to_json, :content_type => :json, :x_wsse => client.x_wsse_string do |response, request, result, &block|
          Emarsys::Response.new(response).result
        end
      when :delete
        RestClient.delete(uri, :content_type => :json, :x_wsse => client.x_wsse_string) do |response, request, result, &block|
          Emarsys::Response.new(response).result
        end
      else
        RestClient.get(uri, :content_type => :json, :x_wsse => client.x_wsse_string) do |response, request, result, &block|
          Emarsys::Response.new(response).result
        end
      end
    end

  end

end