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
      string = 'UsernameToken '
      string += 'Username = "' + username + '", '
      string += 'PasswordDigest = "' + header_password_digest + '", '
      string += 'Nonce = "' + header_nonce + '", '
      string += 'Created = "' + header_created + '"'
      string
    end

    def header_password_digest
      Base64.encode64(calculated_digest).gsub("\n", "")
    end

    def header_nonce
      Digest::MD5.hexdigest(header_created)
    end

    def header_created
      Time.now.utc.iso8601
    end

    def calculated_digest
      Digest::SHA1.hexdigest(header_nonce + header_created + password)
    end

  end
end