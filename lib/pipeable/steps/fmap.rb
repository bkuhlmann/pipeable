# frozen_string_literal: true

module Pipeable
  module Steps
    # Wraps Dry Monads `#fmap` method as a step.
    class Fmap < Abstract
      def call(result) = result.fmap { |object| base_block.call object }
    end
  end
end
