# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Or do
  include Dry::Monads[:result]

  subject(:step) { described_class.new { |value| Failure "Fail: #{value.inspect}." } }

  describe "#call" do
    it "passes success through" do
      result = step.call Success(:test)
      expect(result.success).to eq(:test)
    end

    it "answers modified failure" do
      result = step.call Failure(:test)
      expect(result.failure).to eq("Fail: :test.")
    end
  end
end
