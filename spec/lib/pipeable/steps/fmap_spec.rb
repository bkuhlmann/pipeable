# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Fmap do
  subject(:step) { described_class.new(&:inspect) }

  describe "#call" do
    it "answers success" do
      result = step.call Success(:test)
      expect(result).to be_success(":test")
    end

    it "passes failures through" do
      result = step.call Failure("Danger!")
      expect(result).to be_failure("Danger!")
    end
  end
end
