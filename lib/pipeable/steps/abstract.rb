# frozen_string_literal: true

require "core"
require "dry/monads"

module Pipeable
  module Steps
    # Provides a custom step blueprint.
    class Abstract
      include Dry::Monads[:result]
      include Core::Composable

      def initialize *positionals, **keywords, &block
        @base_positionals = positionals
        @base_keywords = keywords
        @base_block = block
      end

      protected

      attr_reader :base_positionals, :base_keywords, :base_block
    end
  end
end
