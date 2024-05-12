# frozen_string_literal: true

module Pipeable
  module Steps
    # Wraps Dry Monads `#alt_map` method as a step.
    class Amap < Abstract
      def call(result) = result.alt_map { |object| base_block.call object }
    end
  end
end
