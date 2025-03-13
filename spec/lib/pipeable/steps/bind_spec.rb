# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Bind do
  subject(:step) { described_class.new { |value| Success value.inspect } }

  describe "#call" do
    it "answers success" do
      result = step.call Success(:test)
      expect(result).to be_success(":test")
    end

    it "answers failure" do
      step = described_class.new { |value| Failure value.inspect }
      result = step.call Success(:test)

      expect(result).to be_failure(":test")
    end

    it "passes failures through" do
      result = step.call Failure("Danger!")
      expect(result).to be_failure("Danger!")
    end
  end
end
