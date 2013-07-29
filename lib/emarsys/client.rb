module Emarsys
  class Client

    def username
      # TODO raise error if not set
      Emarsys.api_username
    end

    def password
      # TODO raise error if not set
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
      Digest::MD5.hexdigest(Time.new.to_i.to_s)
    end

    def header_created
      Time.new.strftime("%Y-%m-%d %H:%M:%S")
    end

    def calculated_digest
      Digest::SHA1.hexdigest(header_nonce + header_created + password)
    end

  end
end