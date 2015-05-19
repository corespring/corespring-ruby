require 'spec_helper'

describe 'CoreSpring::PlayerToken' do
  let(:client_id) { SecureRandom.hex(13) }
  let(:client_secret) { SecureRandom.hex(13) }
  let(:client) { CoreSpring::PlayerToken.new(client_id, client_secret) }


  describe '#encrypt' do
    let(:options) { CoreSpring::PlayerOptions.new }
    subject { client.encrypt(options) }

    it { should be_a(String) }
  end
end
