# frozen_string_literal: true
module Emarsys
  class Client

    def username
      raise ArgumentError, "Emarsys.api_username is not set" if Emarsys.api_username.nil?
      Emarsys.api_username
    end

    def password
      raise ArgumentError, "Emarsys.api_password is not set" if Emarsys.api_password.nil?
      Emarsys.api_password
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
