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
      Base64.strict_encode64(calculated_digest).strip
    end

    def header_nonce
      @header_nonce ||= SecureRandom::random_bytes(16).each_byte.map { |b| sprintf("%02X",b) }.join
    end

    def header_created
      @header_created ||= Time.now.utc.iso8601
    end

    def calculated_digest
      Digest::SHA1.hexdigest(header_nonce + header_created + password)
    end

    def open_timeout
      Emarsys::Configuration.for(account).open_timeout
    end

    def read_timeout
      Emarsys::Configuration.for(account).read_timeout
    end
  end
end
