require 'spec_helper'

describe "CoreSpring::PlayerOptions" do
  let(:options) { {} }
  let(:player_options) { CoreSpring::PlayerOptions.new(options) }


  describe "defaults" do
    specify { expect(player_options[:secure]).to be_falsey }
    specify { expect(player_options[:expires]).to eq(0) }
    specify { expect(player_options[:mode]).to eq('view') }
    specify { expect(player_options[:item_id]).to be_nil }
    specify { expect(player_options[:session_id]).to eq('*') }
  end


  describe "#player_json" do
    subject { player_options.player_json }

    it { is_expected.to match(/^\{.+\}$/) }
    it { is_expected.to include('"sessionId":') }
    it { is_expected.to include('"itemId":') }


    context "with a session_id" do
      let(:options) { {session_id: "ADF123"} }

      it { is_expected.to include('"sessionId":') }
      it { is_expected.not_to include('"itemId":') }
    end
  end
end
