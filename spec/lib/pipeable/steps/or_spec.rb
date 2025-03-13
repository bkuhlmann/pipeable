# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Or do
  subject(:step) { described_class.new { |value| Failure "Fail: #{value.inspect}." } }

  describe "#call" do
    it "passes success through" do
      result = step.call Success(:test)
      expect(result).to be_success(:test)
    end

    it "answers modified failure" do
      result = step.call Failure(:test)
      expect(result).to be_failure("Fail: :test.")
    end
  end
end
