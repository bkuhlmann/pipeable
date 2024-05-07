# frozen_string_literal: true

module Pipeable
  module Steps
    # Validates result via a callable contract.
    class Validate < Abstract
      def initialize contract, as: nil
        super()
        @contract = contract
        @as = as
      end

      def call(result) = result.bind { |payload| cast payload }

      private

      attr_reader :contract, :as

      def cast payload
        contract.call(payload).to_monad.fmap { |data| as ? data.public_send(as) : data }
      end
    end
  end
end
