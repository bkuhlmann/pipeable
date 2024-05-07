# frozen_string_literal: true

module Pipeable
  module Steps
    # Maps over an enumerable, processes each element, and answers a new enumerable.
    class Map < Abstract
      def call(result) = result.fmap { |collection| collection.map(&base_block) }
    end
  end
end
