# frozen_string_literal: true

require "dry/monads"
require "refinements/array"

module Pipeable
  # Defines the pipe and and associated step methods for an object.
  class Builder < Module
    include Dry::Monads[:result]

    using Refinements::Array

    def initialize container = Steps::Container, pipe: Pipe
      super()

      @container = container
      @pipe = pipe

      define_pipe
      define_steps

      freeze
    end

    private

    attr_reader :container, :pipe

    def define_pipe pipeline = pipe
      define_method :pipe do |input, *steps|
        steps.each { |step| steps.supplant step, method(step) if step.is_a? Symbol }
        pipeline.call(input, *steps)
      end
    end

    def define_steps vessel = container
      vessel.each_key do |key|
        define_method key do |*positionals, **keywords, &block|
          step = vessel[key]
          step.is_a?(Proc) ? step : step.new(*positionals, **keywords, &block)
        end
      end
    end
  end
end
