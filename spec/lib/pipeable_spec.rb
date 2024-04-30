# frozen_string_literal: true

require "containable"
require "spec_helper"

RSpec.describe Pipeable do
  describe ".[]" do
    it "includes custom behavior" do
      container = Module.new.extend Containable
      container.register(:echo) { -> result { result } }
      implementation = Class.new.include described_class[container]

      expect(implementation.ancestors.join(", ")).to include("Pipeable::Builder")
    end
  end

  describe ".included" do
    it "includes behavior" do
      implementation = Class.new.include described_class
      expect(implementation.ancestors).to include(described_class)
    end
  end

  describe ".loader" do
    it "eager loads" do
      expectation = proc { described_class.loader.eager_load force: true }
      expect(&expectation).not_to raise_error
    end

    it "answers unique tag" do
      expect(described_class.loader.tag).to eq("pipeable")
    end
  end
end
