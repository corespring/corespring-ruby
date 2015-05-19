module CoreSpring
  class PlayerToken < APIClient
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
