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
      response = perform_request(emarsys_uri)
      Emarsys::Response.new(response).result
    end

    def emarsys_uri
      [Emarsys.api_endpoint, @path].join('/')
    end

    def converted_params
      Emarsys::ParamsConverter.new(params).convert_to_ids
    end

    private

    def perform_request(uri)
      response = case http_verb.to_sym
      when :post
        RestClient.post uri, converted_params.to_json, :content_type => :json, :x_wsse => client.x_wsse_string
      when :put
        RestClient.put uri, converted_params.to_json, :content_type => :json, :x_wsse => client.x_wsse_string
      when :delete
        RestClient.delete uri, converted_params.to_json, :content_type => :json, :x_wsse => client.x_wsse_string
      else
        RestClient.get uri, :content_type => :json, :x_wsse => client.x_wsse_string
      end
    end

  end

end