# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::Insert do
  include Dry::Monads[:result]

  describe "#call" do
    it "answers success with single element appended to single element" do
      step = described_class.new :z
      expect(step.call(Success(:a)).success).to eq(%i[a z])
    end

    it "answers success with multiple elements appended to single element" do
      step = described_class.new :x, :y, :z
      expect(step.call(Success(:a)).success).to eq(%i[a x y z])
    end

    it "answers success with single element appended to array" do
      step = described_class.new :z
      expect(step.call(Success(%i[a b])).success).to eq(%i[a b z])
    end

    it "answers success with multiple elements appended to array" do
      step = described_class.new :x, :y, :z
      expect(step.call(Success(%i[a b])).success).to eq(%i[a b x y z])
    end

    it "answers success with single element prepended to single element" do
      step = described_class.new :z, at: 0
      expect(step.call(Success(:a)).success).to eq(%i[z a])
    end

    it "answers success with multiple elements prepended to single element" do
      step = described_class.new :z, :y, :x, at: 0
      expect(step.call(Success(:a)).success).to eq(%i[z y x a])
    end

    it "answers success with single element prepended to array" do
      step = described_class.new :z, at: 0
      expect(step.call(Success([:a])).success).to eq(%i[z a])
    end

    it "answers success with multiple elements prepended to array" do
      step = described_class.new :z, :y, :x, at: 0
      expect(step.call(Success([:a])).success).to eq(%i[z y x a])
    end

    it "answers success with single element inserted within array" do
      step = described_class.new :x, at: 2
      expect(step.call(Success(%i[a b c])).success).to eq(%i[a b x c])
    end

    it "answers success with multiple elements inserted within array" do
      step = described_class.new :y, :z, at: 2
      expect(step.call(Success(%i[a b c])).success).to eq(%i[a b y z c])
    end

    it "answers success with array inserted" do
      step = described_class.new [1, 2, 3]
      expect(step.call(Success(:a)).success).to eq([:a, [1, 2, 3]])
    end

    it "answers success with hash inserted" do
      step = described_class.new({b: 2})
      expect(step.call(Success(:a)).success).to eq([:a, {b: 2}])
    end

    it "answers success with any object inserted" do
      object = Object.new
      step = described_class.new object

      expect(step.call(Success(:a)).success).to eq([:a, object])
    end
  end
end
