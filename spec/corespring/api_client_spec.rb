require 'spec_helper'

describe 'CoreSpring::APIClient' do

  let(:client_id) { SecureRandom.hex(13) }
  let(:client_secret) { SecureRandom.hex(13) }
  let(:client) { CoreSpring::APIClient.new(client_id, client_secret) }

  describe 'get_token' do

    describe 'with valid client_id and client_secret' do
      let(:token) { SecureRandom.hex(13) }
      subject { client.get_token }

      before {
        stub_request(:post, "https://platform.corespring.org/auth/access_token")
          .with(:body => "client_id=#{client_id}&client_secret=#{client_secret}")
          .to_return(:status => 200, body: ({ access_token: token }.to_json))
      }

      it { should == token }

    end

    describe 'with invalid client_id and client_secret' do
      subject { client.get_token }
      before {
        stub_request(:post, "https://staging.corespring.org/auth/access_token")
          .with(:body => "client_id=#{client_id}&client_secret=#{client_secret}")
          .to_return(:status => 403, body: ({"code" => 100, "message" => "Invalid credentials", "moreInfo" => ""}.to_json))
      }

      it 'raises an error' do
        expect { subject }.to raise_error
      end

    end

  end

  describe 'encrypt' do
    let(:options) { {} }
    subject { client.encrypt(options) }

    it { should be_a(String) }

  end

end