# frozen_string_literal: true

module Pipeable
  module Steps
    # Use another transaction -- or any command -- which answers a result.
    class Use < Abstract
      def initialize(operation, **)
        super(**)
        @operation = operation
      end

      def call(result) = result.bind { |input| operation.call input }

      private

      attr_reader :operation
    end
  end
end
