require "base64"
require 'json'
require 'rest_client'
require 'uri'

require 'emarsys/client'
require 'emarsys/data_object'
require 'emarsys/error'
require 'emarsys/extensions'
require 'emarsys/field_mapping'
require 'emarsys/params_converter'
require 'emarsys/request'
require 'emarsys/response'

require 'emarsys/data_objects/condition'
require 'emarsys/data_objects/contact_list'
require 'emarsys/data_objects/contact'
require 'emarsys/data_objects/email'
require 'emarsys/data_objects/email_category'
require 'emarsys/data_objects/email_launch_status'
require 'emarsys/data_objects/email_status_code'
require 'emarsys/data_objects/event'
require 'emarsys/data_objects/export'
require 'emarsys/data_objects/field'
require 'emarsys/data_objects/file'
require 'emarsys/data_objects/folder'
require 'emarsys/data_objects/form'
require 'emarsys/data_objects/language'
require 'emarsys/data_objects/segment'
require 'emarsys/data_objects/source'

require "emarsys/version"

# Ruby toolkit for the Emarsys API
module Emarsys
  class << self

    # @!attribute api_endpoint
    #   @return [String] Base URL for emarsys URLs. default: https://api.emarsys.net/api/v2
    # @!attribute api_password
    #   @return [String] API Username given by Emarsys
    # @!attribute api_username
    #   @return [String] API Username given by Emarsys

    attr_accessor :api_endpoint, :api_username, :api_password

    # Base URL for the Emarsys API
    #
    # @return [String] domain which should be used to query the API
    def api_endpoint
      @api_endpoint ||= 'https://api.emarsys.net/api/v2'
    end

    # Set configuration options using a block
    def configure
      yield self
    end

  end
end
