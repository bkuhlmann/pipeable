# frozen_string_literal: true

module Pipeable
  module Steps
    # Wraps Dry Monads `#or` method as a step.
    class Or < Abstract
      def call(result) = result.or { |object| base_block.call object }
    end
  end
end
