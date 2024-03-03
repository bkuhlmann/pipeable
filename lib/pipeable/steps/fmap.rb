# frozen_string_literal: true

module Pipeable
  module Steps
    # Wraps Dry Monads `#fmap` method as a step.
    class Fmap < Abstract
      def call(result) = result.fmap { |input| base_block.call input }
    end
  end
end
