# frozen_string_literal: true
module Emarsys
  class Client
    attr_accessor :account

    def initialize(account = nil)
      self.account = account
    end

    def endpoint
      Emarsys::Configuration.for(account).api_endpoint
    end

    def username
      Emarsys::Configuration.for(account).api_username
    end

    def password
      Emarsys::Configuration.for(account).api_password
    end

    def x_wsse_string
      <<-STRING.strip
      UsernameToken Username="#{username}", PasswordDigest="#{header_password_digest}", Nonce="#{header_nonce}", Created="#{header_created}"
      STRING
    end

    def header_password_digest
      Base64.encode64(calculated_digest).gsub("\n", "")
    end

    def header_nonce
      @header_nonce ||= Random::DEFAULT.bytes(16).each_byte.map { |b| sprintf("%02X",b) }.join
    end

    def header_created
      Time.now.utc.iso8601
    end

    def calculated_digest
      Digest::SHA1.hexdigest(header_nonce + header_created + password)
    end
  end
end
