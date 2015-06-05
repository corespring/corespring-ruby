module CoreSpring
  class APIError < StandardError; end

  class APIClient
    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end


    def get_item(item_id)
      api_response(CoreSpring.get("/items/#{item_id}"), Item)
    end

    def get_item_session(session_id)
      api_response(CoreSpring.get(api_url("/sessions/#{session_id}")), ItemSession)
    end
    
    def create_item_session(item_id)
      api_response(CoreSpring.post(api_url("/items/#{item_id}/sessions")), ItemSession)
    end

    def close_item_session(session_id)
      player_token = PlayerToken.new(@client_id, @client_secret).encrypt(PlayerOptions.new(session_id: session_id))
      api_response(CoreSpring.put("/v2/player/session/complete/#{session_id}.json?playerToken=#{player_token}&apiClient=#{@client_id}"))
    end

    def get_score(session_id)
      api_response(CoreSpring.get(api_url("/sessions/#{session_id}/score.json")), Score)
    end


    private

      def api_url(subset)
        "/api/v2#{subset}?access_token=#{access_token}"
      end
      
      def api_response(response, model=nil)
        json = JSON.parse(response.body)
        raise(APIError, json['message'] || json['error']) if response.code != 200

        if model
          model.new(json)
        else
          json
        end
      end

      def get_access_token
        api_response(CoreSpring.post('/auth/access_token', body: {client_id: @client_id, client_secret: @client_secret}))['access_token']
      end

      def access_token
        @access_token ||= get_access_token
      end
  end
end
