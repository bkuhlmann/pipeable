# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Amap do
  include Dry::Monads[:result]

  subject(:step) { described_class.new { |object| "#{object} (modified)" } }

  describe "#call" do
    it "answers modified failure" do
      result = step.call Failure("Danger")
      expect(result.failure).to eq("Danger (modified)")
    end

    it "passes succeses through" do
      result = step.call Success("Pass")
      expect(result.success).to eq("Pass")
    end
  end
end
