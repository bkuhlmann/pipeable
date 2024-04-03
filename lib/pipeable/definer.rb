# frozen_string_literal: true

require "dry/monads"
require "refinements/array"

module Pipeable
  # Defines the pipe and and associated step methods for an object.
  class Definer < Module
    include Dry::Monads[:result]

    using Refinements::Array

    def initialize container = Steps::Container, pipe: Pipe
      super()
      @container = container
      @pipe = pipe
      @instance_module = Class.new(Module).new
    end

    def included descendant
      super
      define_pipe
      define_steps
      descendant.include instance_module
    end

    private

    attr_reader :container, :pipe, :instance_module

    def define_pipe pipeline = pipe
      instance_module.define_method :pipe do |input, *steps|
        steps.each { |step| steps.supplant step, method(step) if step.is_a? Symbol }
        pipeline.call(input, *steps)
      end
    end

    def define_steps
      instance_module.class_exec container do |dependencies|
        dependencies.each_key do |name|
          define_method name do |*positionals, **keywords, &block|
            step = dependencies[name]
            step.is_a?(Proc) ? step : step.new(*positionals, **keywords, &block)
          end
        end
      end
    end
  end
end
