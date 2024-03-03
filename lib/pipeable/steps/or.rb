# frozen_string_literal: true

module Pipeable
  module Steps
    # Wraps Dry Monads `#or` method as a step.
    class Or < Abstract
      def call(result) = result.or { |input| base_block.call input }
    end
  end
end
