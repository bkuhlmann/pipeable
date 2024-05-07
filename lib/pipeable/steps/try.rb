# frozen_string_literal: true

module Pipeable
  module Steps
    # Sends a risky message to an object which may pass or fail.
    class Try < Abstract
      def initialize(*, catch:, **)
        super(*, **)
        @catch = catch
      end

      def call result
        result.fmap { |object| object.public_send(*base_positionals, **base_keywords) }
      rescue *Array(catch) => error
        Failure error
      end

      private

      attr_reader :catch
    end
  end
end
