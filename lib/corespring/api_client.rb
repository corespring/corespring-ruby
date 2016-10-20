module CoreSpring
  class APIError < StandardError; end

  class APIClient
    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end


    def get_item(item_id)
      api_request(:get, "/items/#{item_id}", Item)
    end

    def get_item_metadata(item_id)
      api_request(:get, "/item/#{item_id}/metadata")
    end

    def get_item_session(session_id)
      api_request(:get, "/sessions/#{session_id}", ItemSession)
    end
    
    def create_item_session(item_id)
      api_request(:post, "/items/#{item_id}/sessions", ItemSession)
    end

    def reopen_item_session(session_id)
      api_request(:put, "/sessions/#{session_id}/reopen")
    end

    def complete_item_session(session_id)
      api_request(:put, "/sessions/#{session_id}/complete")
    end

    def get_score(session_id)
      api_request(:get, "/sessions/#{session_id}/score.json", Score)
    end


    private

      def api_request(http_method, url, model=nil)
        api_response(CoreSpring.send(http_method.to_s, api_url(url)), model)
      end

      def api_url(subset)
        "/api/v2#{subset}?access_token=#{access_token}"
      end
      
      def api_response(response, model=nil)
        json = JSON.parse(response.body)
        raise(APIError, json['message'] || json['error'] || json) if response.code != 200

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
