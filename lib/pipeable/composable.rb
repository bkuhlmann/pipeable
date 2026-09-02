# frozen_string_literal: true

module Pipeable
  # Allows objects to be functionally composable.
  module Composable
    def >> other
      warn "`#>>` is deprecated, use `Core::Composable#>>` instead.", category: :deprecated
      method(:call) >> other
    end

    def << other
      warn "`#<<` is deprecated, use `Core::Composable#<<` instead.", category: :deprecated
      method(:call) << other
    end

    def call
      fail NoMethodError, "`#{self.class.name}##{__method__}` must be implemented."
    end
  end
end
