# frozen_string_literal: true

module Pipeable
  module Steps
    # Inserts elements before or after an object.
    class Insert < Abstract
      LAST = -1

      def initialize(*, at: LAST)
        super(*)
        @at = at
      end

      def call result
        result.fmap do |object|
          cast = object.is_a?(Array) ? object : [object]
          cast.insert(at, *base_positionals)
        end
      end

      private

      attr_reader :at
    end
  end
end
