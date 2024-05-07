# frozen_string_literal: true

module Pipeable
  module Steps
    # Inserts elements before or after an object.
    class Insert < Abstract
      LAST = -1

      def initialize(*positionals, at: LAST, **)
        super(*positionals, **)
        @value = positionals.empty? ? base_keywords : positionals.flatten
        @at = at
      end

      def call result
        result.fmap do |object|
          cast = object.is_a?(Array) ? object : [object]
          value.is_a?(Array) ? cast.insert(at, *value) : cast.insert(at, value)
        end
      end

      private

      attr_reader :value, :at
    end
  end
end
