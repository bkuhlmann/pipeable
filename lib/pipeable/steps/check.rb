# frozen_string_literal: true

require "marameters"

module Pipeable
  module Steps
    # Checks if proof is true and answers success (passthrough) or failure (with optional argument).
    class Check < Abstract
      def initialize proof, message
        super()
        @proof = proof
        @message = message
      end

      def call result
        result.bind do |object|
          answer = question object
          answer == true || answer.is_a?(Success) ? result : Failure(object)
        end
      end

      private

      attr_reader :proof, :message

      def question object
        splat = Marameters.categorize proof.method(message).parameters, object
        proof.public_send(message, *splat.positionals, **splat.keywords, &splat.block)
      end
    end
  end
end
