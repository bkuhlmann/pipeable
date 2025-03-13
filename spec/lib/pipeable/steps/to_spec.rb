# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pipeable::Steps::To do
  subject(:step) { described_class.new object.new, :for }

  let :object do
    Class.new Pipeable::Steps::Abstract do
      def for(first, last: 2) = Success base_positionals.append(first, last)
    end
  end

  describe "#call" do
    it "answers success with monadic object" do
      result = step.call Success([1, {last: 3}])
      expect(result).to be_success([1, 3])
    end

    context "with non-monadic object" do
      subject(:step) { described_class.new object.new, :for }

      it "answers success" do
        result = step.call Success([1, {last: 3}])
        expect(result).to be_success([1, 3])
      end
    end

    context "with non-monadic response" do
      let :object do
        Class.new Pipeable::Steps::Abstract do
          def for(first, last: 2) = base_positionals.append(first, last)
        end
      end

      it "answers success" do
        result = step.call Success([1, {last: 3}])
        expect(result).to be_success([1, 3])
      end
    end

    context "with keywords" do
      subject(:step) { described_class.new object, :for }

      let :object do
        Struct.new :label do
          def self.for(**) = Dry::Monads::Success new(**)
        end
      end

      it "answers success" do
        result = step.call Success(label: :test)
        expect(result).to be_success(object[label: :test])
      end
    end

    it "passes failures through" do
      result = step.call Failure("Danger!")
      expect(result).to be_failure("Danger!")
    end
  end
end
