require 'spec_helper'

describe "CoreSpring::PriorUse" do
  describe "#initialize" do
    let(:attrs) { {'contributorName' => "Patrick", 'primarySubject' => {'id' => "asdf"}} }

    subject { CoreSpring::PriorUse.new(attrs) }

    specify { expect(subject.contributor_name).to eq("Patrick") }
    specify { expect(subject.primary_subject).to be_a(CoreSpring::PrimarySubject) }
  end
end
