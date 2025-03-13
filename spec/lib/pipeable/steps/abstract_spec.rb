# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Abstract do
  describe ".new" do
    let(:implementation) { Class.new described_class }

    let :proof do
      /
        @base_positionals=\["test"\],\s
        @base_keywords=\{label:\s"Value"\},\s
        @base_block=\#<Proc.+
      /x
    end

    it "answers no attributes when not given" do
      step = implementation.new

      expect(step.inspect).to match(
        /
          @base_positionals=\[\],\s
          @base_keywords=\{\},\s
          @base_block=nil
        /x
      )
    end

    it "answers positional, keyword, and block attributes when given" do
      function = proc { "test" }
      step = implementation.new "test", label: "Value", &function

      expect(step.inspect).to match(proof)
    end
  end
end
