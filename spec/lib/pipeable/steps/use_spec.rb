# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Use do
  subject(:step) { described_class.new command }

  let(:command) { -> input { Success input * 2 } }

  describe "#call" do
    it "answers success" do
      result = step.call Success(3)
      expect(result).to be_success(6)
    end

    it "passes failure through" do
      result = step.call Failure("Danger!")
      expect(result).to be_failure("Danger!")
    end
  end
end
