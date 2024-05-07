# frozen_string_literal: true

module Pipeable
  module Steps
    # Validates result via a callable contract.
    class Validate < Abstract
      def initialize(contract, as: :to_h, **)
        super(**)
        @contract = contract
        @as = as
      end

      def call result
        result.bind do |payload|
          value = contract.call payload

          return Failure value if value.failure?

          Success(as ? value.public_send(as) : value)
        end
      end

      private

      attr_reader :contract, :as
    end
  end
end
