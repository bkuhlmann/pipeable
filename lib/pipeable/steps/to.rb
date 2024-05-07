# frozen_string_literal: true

require "marameters"

module Pipeable
  module Steps
    # Delegates to a non-callable object which automatically wraps the result if necessary.
    class To < Abstract
      def initialize(object, message, **)
        super(**)
        @object = object
        @message = message
      end

      def call result
        result.bind do |arguments|
          splat = Marameters.categorize object.method(message).parameters, arguments
          wrap object.public_send(message, *splat.positionals, **splat.keywords, &splat.block)
        end
      end

      private

      attr_reader :object, :message

      def wrap(result) = result.is_a?(Dry::Monads::Result) ? result : Success(result)
    end
  end
end
