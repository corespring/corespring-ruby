require 'spec_helper'

describe 'CoreSpring::APIClient' do
  let(:client_id) { SecureRandom.hex(13) }
  let(:client_secret) { SecureRandom.hex(13) }
  let(:client) { CoreSpring::APIClient.new(client_id, client_secret) }

  let(:item_id) { SecureRandom.hex(13) }
  let(:collection_id) { SecureRandom.hex(13) }
  let(:session_id) { SecureRandom.hex(13) }
  let(:access_token) { SecureRandom.hex(13) }


  before(:each) do
    stub_request(:post, "https://platform.corespring.org/auth/access_token").
      with(:body => "client_id=#{client_id}&client_secret=#{client_secret}").
      to_return(:status => 200, :body => "{\"access_token\": \"#{access_token}\"}", :headers => {})
  end

  
  describe "#get_items" do
    before do
      stub_request(:get, "https://platform.corespring.org/api/v1/items?access_token=#{access_token}").
         to_return(:status => 200, :body => "[{}]", :headers => {})
    end

    subject { client.get_items }

    it { is_expected.not_to be_nil }


    context "for a collection" do
      before do
        stub_request(:get, "https://platform.corespring.org/api/v1/collections/#{collection_id}/items?access_token=#{access_token}").
           to_return(:status => 200, :body => "[{}]", :headers => {})
      end

      subject { client.get_items(collection_id) }

      it { is_expected.not_to be_nil }
    end

    context "with an invalid token" do
      before do
        stub_request(:post, "https://platform.corespring.org/auth/access_token")
          .with(:body => "client_id=#{client_id}&client_secret=#{client_secret}")
          .to_return(:status => 403, body: ({"code" => 100, "message" => "Invalid credentials", "moreInfo" => ""}.to_json))
      end

      specify { expect { subject }.to raise_error }
    end
  end


  describe "#get_item" do
    before do
      stub_request(:get, "https://platform.corespring.org/api/v1/items/#{item_id}?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end

    subject { client.get_item(item_id) }
    
    it { is_expected.not_to be_nil }
  end


  describe "#get_item_session" do
    before do
      stub_request(:get, "https://platform.corespring.org/api/v2/sessions/#{session_id}?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end

    subject { client.get_item_session(session_id) }

    it { is_expected.not_to be_nil }
  end


  describe "#create_item_session" do
    before do
      stub_request(:post, "https://platform.corespring.org/api/v2/items/#{item_id}/sessions?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end

    subject { client.create_item_session(item_id) }

    it { is_expected.not_to be_nil }
  end


  describe "#reopen_item_session" do
    before do
      stub_request(:post, "https://platform.corespring.org/api/v1/items/#{item_id}/sessions/#{session_id}/reopen?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end

    subject { client.reopen_item_session(item_id, session_id) }

    it { is_expected.not_to be_nil }
  end
end
