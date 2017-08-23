# frozen_string_literal: true
module Emarsys
  class Configuration

    class << self
      attr_accessor :config_sets

      def for(account)
        self.config_sets ||= {}
        if account.nil?
          raise Emarsys::AccountRequired unless Emarsys.allow_default_configuration
          account = :default
        end
        account_sym = account.to_sym
        if self.config_sets[account_sym].nil?
          raise Emarsys::AccountNotConfigured
        end
        self.config_sets[account_sym]
      end

      def configure(account: :default)
        self.config_sets ||= {}
        account_sym = account.to_sym
        self.config_sets[account_sym] ||= self.new
        yield self.config_sets[account_sym]
      end
    end

    # @!attribute api_endpoint
    #   @return [String] Base URL for emarsys URLs. default: https://api.emarsys.net/api/v2
    # @!attribute api_password
    #   @return [String] API Username given by Emarsys
    # @!attribute api_username
    #   @return [String] API Username given by Emarsys

    attr_writer :api_endpoint, :api_username, :api_password

    # Base URL for the Emarsys API
    #
    # @return [String] domain which should be used to query the API
    def api_endpoint
      @api_endpoint ||= 'https://api.emarsys.net/api/v2'
    end

    def api_username
      @api_username or raise ArgumentError.new('api_username is not set')
    end

    def api_password
      @api_password or raise ArgumentError.new('api_password is not set')
    end

    # @!attribute open_timeout
    #   @return [Integer] Connect Timeout. default: RestClient timeout which is 60s
    # @!attribute read_timeout
    #   @return [Integer] Read Timeout. default: RestClient timeout which is 60s
    attr_accessor :open_timeout, :read_timeout

  end
end
