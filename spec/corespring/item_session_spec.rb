require 'spec_helper'

describe "CoreSpring::ItemSession" do
  describe "#initialize" do
    let(:attrs) { {'id' => 'asdf', 'itemId' => 'qwer', 'components' => {'foo' => {'answers' => ['choiceB']}}} }

    subject { CoreSpring::ItemSession.new(attrs) }
    
    specify { expect(subject.id).to eq('asdf') }
    specify { expect(subject.components).to include(:foo) }
    specify { expect(subject.components[:foo]).to be_a(CoreSpring::Component) }
  end
end
