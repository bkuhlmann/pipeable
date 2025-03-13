# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Check do
  subject(:step) { described_class.new proof, :include? }

  let(:proof) { %i[a b c] }

  describe "#call" do
    it "answers success when true" do
      result = Success :a
      expect(step.call(result)).to be_success(:a)
    end

    it "answers success when a success" do
      allow(proof).to receive(:include?).and_return(Success("Included."))
      result = Success :a

      expect(step.call(result)).to be_success(:a)
    end

    it "answers failure when false" do
      result = Success :x
      expect(step.call(result)).to be_failure(:x)
    end
  end
end
