# frozen_string_literal: true

module Pipeable
  module Steps
    # Merges initialized attributes with step object for use by subsequent step.
    class Merge < Abstract
      def initialize(as: :step, **)
        super(**)
        @as = as
      end

      def call result
        result.fmap do |object|
          if object.is_a? Hash
            object.merge! base_keywords
          else
            {as => object}.merge!(base_keywords)
          end
        end
      end

      private

      attr_reader :as
    end
  end
end
