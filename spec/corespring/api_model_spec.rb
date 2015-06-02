require 'spec_helper'

describe 'CoreSpring::APIModel' do
  class FooModel < CoreSpring::APIModel
    attr_accessor :id, :not_camel_case
  end

  describe "#initialize" do
    subject { FooModel.new(attrs) }

    context "with correct attributes" do
      let(:attrs) { {id: :abc123} }
      specify { expect(subject.id).to eq(:abc123) }
    end

    context "with camelCase attributes" do
      let(:attrs) { {notCamelCase: :value} }
      specify { expect(subject.not_camel_case).to eq(:value) }
    end

    context "with incorrect attributes" do
      let(:attrs) { {foo: :bar} }
      specify { expect { subject }.to raise_error }
    end
  end
end
