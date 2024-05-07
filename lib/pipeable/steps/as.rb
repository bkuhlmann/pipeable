# frozen_string_literal: true

module Pipeable
  module Steps
    # Messages object, with optional arguments, as different result.
    class As < Abstract
      def call result
        result.fmap { |object| object.public_send(*base_positionals, **base_keywords) }
      end
    end
  end
end
