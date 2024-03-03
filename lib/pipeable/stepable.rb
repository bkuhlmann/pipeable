# frozen_string_literal: true

require "dry/monads"
require "refinements/array"

module Pipeable
  # Allows an object to pipe steps together to composed a single result.
  class Stepable < Module
    include Dry::Monads[:result]

    using Refinements::Array

    def initialize steps = Steps::Container, pipe: Pipe
      super()
      @steps = steps
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

    attr_reader :steps, :pipe, :instance_module

    def define_pipe
      local_pipe = pipe

      instance_module.define_method :pipe do |input, *steps|
        steps.each { |step| steps.supplant step, method(step) if step.is_a? Symbol }
        local_pipe.call(input, *steps)
      end
    end

    def define_steps
      instance_module.class_exec steps do |container|
        container.each_key do |name|
          define_method name do |*positionals, **keywords, &block|
            step = container[name]
            step.is_a?(Proc) ? step : step.new(*positionals, **keywords, &block)
          end
        end
      end
    end
  end
end
