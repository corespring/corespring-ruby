module CoreSpring
  class APIClient

    def self.get_token(client_id, client_secret)
      result = CoreSpring.post('/auth/access_token', body: {
        client_id: client_id,
        client_secret: client_secret  
      })
      if (result['access_token'].nil?)
        throw :invalid_credentials
      else
        result['access_token']
      end
    end
    
  end
end