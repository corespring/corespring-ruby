require 'spec_helper'

describe 'get_token' do
  let(:client_id) { SecureRandom.hex(13) }
  let(:client_secret) { SecureRandom.hex(13) }

  describe 'with valid client_id and client_secret' do
    let(:token) { SecureRandom.hex(13) }

    before {
      stub_request(:post, "http://staging.corespring.org/auth/access_token")
        .with(:body => "client_id=#{client_id}&client_secret=#{client_secret}")
        .to_return(:status => 200, body: ({ access_token: token }.to_json))
    }

    it 'returns token' do
      CoreSpring::APIClient.get_token(client_id, client_secret).should == token
    end

  end

  describe 'with invalid client_id and client_secret' do
    before {
      stub_request(:post, "http://staging.corespring.org/auth/access_token")
        .with(:body => "client_id=#{client_id}&client_secret=#{client_secret}")
        .to_return(:status => 403, body: ({"code" => 100, "message" => "Invalid credentials", "moreInfo" => ""}.to_json))
    }

    it 'raises an error' do
      expect { CoreSpring::APIClient.get_token(client_id, client_secret) }.to raise_error
    end

  end

end