module CoreSpring
  class APIClient
    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end

    def get_token
      if @token.nil?
        result = CoreSpring.post('/auth/access_token', body: {
          client_id: @client_id,
          client_secret: @client_secret
        })
        if result.code == 200
          @token = JSON.parse(result.body)['access_token']
        else
          throw :invalid_credentials
        end
      end
      @token
    end

    def encrypt(player_options)
      aes = OpenSSL::Cipher::Cipher.new("AES-128-CBC")
      iv = aes.random_iv
      iv_hexed = iv.unpack('H*')[0]
      key = digest_key(@client_secret)
      aes.encrypt
      aes.key = key
      aes.iv = iv
      cipher = aes.update(player_options.player_json)
      cipher << aes.final

      encrypted_hexed = cipher.unpack('H*')[0]
      "#{encrypted_hexed}--#{iv_hexed}"
    end


    private
      def digest_key(raw_key)
        digest = Digest::MD5.new
        digest.update(raw_key)
        digest.digest
      end
  end
end
