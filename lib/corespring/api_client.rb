module CoreSpring
  class APIClient

    def self.get_token(client_id, client_secret)
      result = CoreSpring.post('/auth/access_token', body: {
        client_id: client_id,
        client_secret: client_secret  
      })
      if result.code == 200
        JSON.parse(result.body)['access_token']
      else
        throw :invalid_credentials
      end
    end
    
  end
end