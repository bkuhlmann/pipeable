# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Validate do
  subject(:step) { described_class.new contract }

  let(:contract) { Dry::Schema.Params { required(:label).filled :string } }

  describe "#call" do
    it "answers success with valid payload and defaults" do
      result = step.call Success(label: "Test")
      expect(result).to be_success(contract.call(label: "Test"))
    end

    it "answers success with valid payload and hash conversion" do
      step = described_class.new contract, as: :to_h
      result = step.call Success(label: "Test")

      expect(result).to be_success(label: "Test")
    end

    it "answers success with valid payload as specific type" do
      step = described_class.new contract, as: :inspect
      result = step.call Success(label: "Test")

      expect(result).to be_success(%(#<Dry::Schema::Result{label: "Test"} errors={} path=[]>))
    end

    it "answers failure with invalid payload" do
      result = step.call Success(bogus: "invalid")
      expect(result.failure.errors.to_h).to eq(label: ["is missing"])
    end

    it "answers failure with passthrough failure" do
      result = step.call Failure("Danger!")
      expect(result.failure).to eq("Danger!")
    end
  end
end
