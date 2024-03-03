# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Bind do
  include Dry::Monads[:result]

  subject(:step) { described_class.new { |value| Success value.inspect } }

  describe "#call" do
    it "answers success" do
      result = step.call Success(:test)
      expect(result.success).to eq(":test")
    end

    it "answers failure" do
      step = described_class.new { |value| Failure value.inspect }
      result = step.call Success(:test)

      expect(result.failure).to eq(":test")
    end

    it "passes failures through" do
      result = step.call Failure("Danger!")
      expect(result.failure).to eq("Danger!")
    end
  end
end
