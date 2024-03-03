# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Fmap do
  include Dry::Monads[:result]

  subject(:step) { described_class.new(&:inspect) }

  describe "#call" do
    it "answers success" do
      result = step.call Success(:test)
      expect(result.success).to eq(":test")
    end

    it "passes failures through" do
      result = step.call Failure("Danger!")
      expect(result.failure).to eq("Danger!")
    end
  end
end
