# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Tee do
  subject(:step) { described_class.new operation, :call }

  let(:operation) { instance_spy Proc }

  describe "#call" do
    context "with success" do
      let(:result) { Success "test" }

      it "messages operation with no arguments" do
        step.call result
        expect(operation).to have_received(:call)
      end

      it "messages operation with positional and keyword arguments" do
        step = described_class.new operation, :call, "one", two: 2
        step.call result

        expect(operation).to have_received(:call).with("one", two: 2)
      end

      it "answers success" do
        expect(step.call(result)).to eq(result)
      end
    end

    context "with failure" do
      let(:result) { Failure "Danger!" }

      it "messages operation" do
        step.call result
        expect(operation).to have_received(:call)
      end

      it "answers failure" do
        expect(step.call(result)).to eq(result)
      end
    end
  end
end
