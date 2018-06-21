# frozen_string_literal: true
require "base64"
require 'forwardable'
require 'json'
require 'rest_client'
require 'uri'
require 'securerandom'

require 'emarsys/configuration'
require 'emarsys/client'
require 'emarsys/country'
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
    extend Forwardable

    attr_accessor :allow_default_configuration

    def_delegators :configuration, :configure

    def configuration
      @configuration ||= Emarsys::Configuration
    end
  end
end
