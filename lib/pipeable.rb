# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.new.then do |loader|
  loader.tag = File.basename __FILE__, ".rb"
  loader.push_dir __dir__
  loader.setup
end

# Main namespace.
module Pipeable
  def self.included(descendant) = descendant.include Definer.new

  def self.loader registry = Zeitwerk::Registry
    @loader ||= registry.loaders.find { |loader| loader.tag == File.basename(__FILE__, ".rb") }
  end

  def self.[](container) = Definer.new(container)

  def self.with(...)
    warn "`#{self.class}.#{__method__}` is deprecated, use `.[]` instead.", category: :deprecated
    Definer.new(...)
  end
end
