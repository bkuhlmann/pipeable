# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::As do
  include Dry::Monads[:result]

  subject(:step) { described_class.new :inspect }

  describe "#call" do
    it "answers success with single positional argument" do
      result = step.call Success(:test)
      expect(result.success).to eq(":test")
    end

    it "answers success with multiple positional arguments" do
      step = described_class.new :fetch, :label
      result = step.call Success(label: "Test")

      expect(result.success).to eq("Test")
    end

    it "answers success with keyword arguments" do
      step = described_class.new :transform_keys, label: :title
      result = step.call Success(label: "Test")

      expect(result.success).to eq(title: "Test")
    end

    it "passes failures through" do
      result = step.call Failure("Danger!")
      expect(result.failure).to eq("Danger!")
    end
  end
end
