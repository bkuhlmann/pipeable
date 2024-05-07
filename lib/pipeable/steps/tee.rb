# frozen_string_literal: true

module Pipeable
  module Steps
    # Messages operation, without any checks, while passing input through as output.
    class Tee < Abstract
      def initialize(operation, *, **)
        super(*, **)
        @operation = operation
      end

      def call result
        operation.public_send(*base_positionals, **base_keywords)
        result
      end

      private

      attr_reader :operation
    end
  end
end
