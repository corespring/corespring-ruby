module CoreSpring
  class APIError < StandardError; end

  class APIClient
    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end


    def get_item(item_id)
      api_response(CoreSpring.get("/api/v2/items/#{item_id}?access_token=#{access_token}"), Item)
    end


    def get_item_session(session_id)
      api_response(CoreSpring.get("/api/v2/sessions/#{session_id}?access_token=#{access_token}"), ItemSession)
    end
    
    def create_item_session(item_id)
      api_response(CoreSpring.post("/api/v2/items/#{item_id}/sessions?access_token=#{access_token}"), ItemSession)
    end


    def update_item_session(item_session)
      # XXX
    end


    def get_score(session_id)
      api_response(CoreSpring.get("/api/v2/sessions/#{session_id}/score.json?access_token=#{access_token}"), Score)
    end


    private
      
      def api_response(response, model=nil)
        json = JSON.parse(response.body)
        raise(APIError, json['message']) if response.code != 200

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
