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
      uri = URI.parse([Emarsys.api_endpoint, @path].join('/'))

      http_request = build_request_object(uri, params.stringify_keys)
      http_request["Content-Type"] = 'application/json'
      http_request["X-WSSE"] = client.x_wsse_string

      http = Net::HTTP.new(uri.host, uri.port)

      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      http_result = http.request(http_request)

      Emarsys::Response.new(http_result).result
    end


    private

    def build_request_object(uri, data)
      case http_verb.to_sym
      when :post
        if data["file"]
          r = Net::HTTP::Post::Multipart.new(uri.request_uri, data)
        else
          r = Net::HTTP::Put.new(uri.request_uri)
          r.set_form_data(data)
        end
        return r
      when :put
        r = Net::HTTP::Put.new(uri.request_uri)
        r.set_form_data(data)
        return r
      when :delete
        r = Net::HTTP::Delete.new(uri.request_uri)
        r.set_form_data(data)
        return r
      else
        r = Net::HTTP::Get.new(uri.request_uri)
        r.set_form_data(data)
        return r
      end
    end

  end

end