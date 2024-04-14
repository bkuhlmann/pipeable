# frozen_string_literal: true

module Pipeable
  # Allows objects to be functionally composable.
  module Composable
    def >>(other) = method(:call) >> other

    def <<(other) = method(:call) << other

    def call = fail NoMethodError, "`#{self.class.name}##{__method__}` must be implemented."
  end
end
