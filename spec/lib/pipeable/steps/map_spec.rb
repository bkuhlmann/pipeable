# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Map do
  subject(:step) { described_class.new(&:to_s) }

  describe "#call" do
    it "answers success" do
      result = step.call Success(%i[a b c])
      expect(result).to be_success(%w[a b c])
    end

    it "passes failures through" do
      result = step.call Failure("Danger!")
      expect(result).to be_failure("Danger!")
    end
  end
end
