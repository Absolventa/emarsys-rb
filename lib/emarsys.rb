require 'uri'
require 'net/https'
require 'json'
require "base64"

require 'emarsys/client'
require 'emarsys/request'
require 'emarsys/response'
require 'emarsys/extensions'

require 'emarsys/data_objects/base'
require 'emarsys/data_objects/email'
require 'emarsys/data_objects/language'

require "emarsys/version"

module Emarsys

  class << self

    attr_accessor :api_endpoint, :api_username, :api_password

    ## Returns the domain which should be used to query the API
    def api_endpoint
      @api_endpoint ||= 'https://suite5.emarsys.net/api/v2'
    end

    # Set configuration options using a block
    def configure
      yield self
    end

  end
end
