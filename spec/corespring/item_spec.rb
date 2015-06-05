require 'spec_helper'

describe "CoreSpring::Item" do
  describe "#initialize" do
    let(:attrs) do
      {
        'primarySubject' => {'id' => 'asdf'}, 
        'standards' => [{'id' => 'asdf'}], 
        'priorUse' => {'contributorName' => 'Patrick', 'primarySubject' => {'id' => 'asdf'}}
      }
    end

    subject { CoreSpring::Item.new(attrs)}

    specify { subject.standards.each {|s| expect(s).to be_a(CoreSpring::Standard)} }
    specify { expect(subject.primary_subject).to be_a(CoreSpring::PrimarySubject) }
    specify { expect(subject.prior_use).to be_a(CoreSpring::PriorUse) }
  end
end
