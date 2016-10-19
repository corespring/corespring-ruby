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

 

  describe "#get_item" do
    before do
      stub_request(:get, "https://platform.corespring.org/api/v2/items/#{item_id}?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end

    subject { client.get_item(item_id) }
    
    it { is_expected.to be_a(CoreSpring::Item) }
  end


  describe "#get_item_session" do
    before do
      stub_request(:get, "https://platform.corespring.org/api/v2/sessions/#{session_id}?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end

    subject { client.get_item_session(session_id) }

    it { is_expected.to be_a(CoreSpring::ItemSession) }
  end


  describe "#create_item_session" do
    before do
      stub_request(:post, "https://platform.corespring.org/api/v2/items/#{item_id}/sessions?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end

    subject { client.create_item_session(item_id) }

    it { is_expected.to be_a(CoreSpring::ItemSession) }
  end


  describe "#reopen_item_session" do
    before do
      stub_request(:put, "https://platform.corespring.org/api/v2/sessions/#{session_id}/reopen?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end

    subject { client.reopen_item_session(session_id) }

    it { is_expected.not_to be_nil }
  end


  describe "#complete_item_session" do
    before do
      stub_request(:put, "https://platform.corespring.org/api/v2/sessions/#{session_id}/complete?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end

    subject { client.complete_item_session(session_id) }

    it { is_expected.not_to be_nil }
  end


  describe "#get_score" do
    before do
      stub_request(:get, "https://platform.corespring.org/api/v2/sessions/#{session_id}/score.json?access_token=#{access_token}").
         to_return(:status => 200, :body => "{}", :headers => {})
    end
    
    subject { client.get_score(session_id) }

    it { is_expected.to be_a(CoreSpring::Score) }
  end
end
