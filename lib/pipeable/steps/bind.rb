# frozen_string_literal: true

module Pipeable
  module Steps
    # Wraps Dry Monads `#bind` method as a step.
    class Bind < Abstract
      def call(result) = result.bind { |object| base_block.call object }
    end
  end
end
