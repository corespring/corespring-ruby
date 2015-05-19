module CoreSpring
  class APIError < StandardError; end

  class APIClient
    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end


    # TODO does this support pagination?
    def get_items(collection_id=nil)
      uri = if collection_id
              "/api/v1/collections/#{collection_id}/items"
            else
              "/api/v1/items"
            end

      api_response CoreSpring.get("#{uri}?access_token=#{access_token}")
    end

    def get_item(item_id)
      api_response CoreSpring.get("/api/v1/items/#{item_id}?access_token=#{access_token}")
    end


    def get_item_session(session_id)
      api_response CoreSpring.get("/api/v2/sessions/#{session_id}?access_token=#{access_token}")
    end
    
    def create_item_session(item_id)
      api_response CoreSpring.post("/api/v2/items/#{item_id}/sessions?access_token=#{access_token}")
    end

    def reopen_item_session(item_id, session_id)
      api_response CoreSpring.post("/api/v1/items/#{item_id}/sessions/#{session_id}/reopen?access_token=#{access_token}")
    end


    private
      
      def api_response(response)
        json = JSON.parse(response.body)
        raise(APIError, json['message']) if response.code != 200
        json
      end

      def get_access_token
        api_response(CoreSpring.post('/auth/access_token', body: {client_id: @client_id, client_secret: @client_secret}))['access_token']
      end

      def access_token
        @access_token ||= get_access_token
      end
  end
end
