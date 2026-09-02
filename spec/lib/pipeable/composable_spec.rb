# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Composable do
  subject(:composable) { implementation.new }

  let :implementation do
    Class.new do
      include Pipeable::Composable

      def call(value) = value + default

      def initialize default = 5
        @default = default
      end

      private

      attr_reader :default
    end
  end

  let(:multiplier) { -> value { value * 2 } }

  describe "#>>" do
    it "prints warning" do
      expectation = proc { (composable >> multiplier).call 3 }
      warning = "`#>>` is deprecated, use `Core::Composable#>>` instead.\n"

      expect(&expectation).to output(warning).to_stderr
    end

    it "answers computed value when first" do
      result = (composable >> multiplier).call 3
      expect(result).to eq(16)
    end

    it "answers computed value when last" do
      result = (multiplier >> composable).call 3
      expect(result).to eq(11)
    end
  end

  describe "#<<" do
    it "prints warning" do
      expectation = proc { (composable << multiplier).call 3 }
      warning = "`#<<` is deprecated, use `Core::Composable#<<` instead.\n"

      expect(&expectation).to output(warning).to_stderr
    end

    it "answers computed value when first" do
      result = (composable << multiplier).call 3
      expect(result).to eq(11)
    end

    it "answers computed value when last" do
      result = (multiplier << composable).call 3
      expect(result).to eq(16)
    end
  end

  describe "#call" do
    it "answers computed value" do
      expect(composable.call(10)).to eq(15)
    end

    it "fails when not implemented" do
      expectation = proc { Class.new.include(described_class).new.call }
      expect(&expectation).to raise_error(NoMethodError, "`#call` must be implemented.")
    end
  end
end
