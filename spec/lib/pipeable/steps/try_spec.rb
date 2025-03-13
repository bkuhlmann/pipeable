# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Try do
  subject(:step) { described_class.new :inspect, catch: NoMethodError }

  describe "#call" do
    it "answers success with no arguments" do
      result = step.call Success(:test)
      expect(result).to be_success(":test")
    end

    it "answers success with positional arguments" do
      step = described_class.new :split, ".", catch: NoMethodError
      result = step.call Success("one.two")

      expect(result).to be_success(%w[one two])
    end

    it "answers success with positional and keyword arguments" do
      step = described_class.new :transform_keys, label: :title, catch: NoMethodError
      result = step.call Success(label: "Test")

      expect(result).to be_success(title: "Test")
    end

    it "answers failure with invalid message" do
      step = described_class.new :bogus, catch: NoMethodError
      result = step.call Success("test")

      expect(result.failure.inspect).to match(/NoMethodError.+undefined method 'bogus'/)
    end

    it "answers failure with invalid arguments" do
      step = described_class.new :split, :bogus, catch: TypeError
      result = step.call Success("test")

      expect(result.failure.inspect).to match(/TypeError.+wrong argument type.+/)
    end

    it "answers exception with wrong exception caught" do
      step = described_class.new :bogus, catch: ArgumentError
      expectation = proc { step.call Success("test") }

      expect(&expectation).to raise_error(NoMethodError, /undefined method/)
    end

    it "passes failures through" do
      result = step.call Failure("Danger!")
      expect(result).to be_failure("Danger!")
    end
  end
end
