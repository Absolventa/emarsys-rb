# frozen_string_literal: true
module Emarsys
  class Response
    attr_accessor :code, :text, :data, :status

    def initialize(response)
      if response.headers[:content_type] == 'text/csv'
        self.code = 0
        self.data = response.body
      else
        json = JSON.parse(response)
        self.code = json['replyCode']
        self.text = json['replyText']
        self.data = json['data']
      end

      self.status = response.code if response.respond_to?(:code)

      if code != 0
        if status == 401
          raise Emarsys::Unauthorized.new(code, text, status)
        elsif status == 429
          raise Emarsys::TooManyRequests.new(code, text, status)
        else
          raise Emarsys::BadRequest.new(code, text, status)
        end
      end
    end
  end
end
