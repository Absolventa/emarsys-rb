# frozen_string_literal: true
module Emarsys
  # Custom error class for rescuing from Emarsys errors
  class Error < StandardError
    attr_reader :code

    def initialize(code, text, status, data = nil)
      @code = code
      @text = text
      @status = status
      @data = data
      super(build_error_message)
    end

    def build_error_message
      "HTTP-Code: #{@status}, Emarsys-Code: #{@code} - #{@text}\nEmarys-Data: #{@data.inspect}"
    end
  end

  # Raised when Emarsys returns a 400 HTTP status code
  class BadRequest < Error; end

  # Raised when Emarsys returns a 401 HTTP status code
  class Unauthorized < Error; end

  # Raised when Emarsys returns a 429 HTTP status code
  class TooManyRequests < Error; end

  # Raised when Emarsys returns a 500 HTTP status code
  class InternalServerError < Error; end

  class AccountNotConfigured < StandardError; end

  class AccountRequired < StandardError; end
end
