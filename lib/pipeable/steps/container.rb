# frozen_string_literal: true

require "containable"

module Pipeable
  module Steps
    # Registers default steps.
    module Container
      extend Containable

      register :alt, Or
      register :as, As
      register :bind, Bind
      register :check, Check
      register :fmap, Fmap
      register :insert, Insert
      register :map, Map
      register :merge, Merge
      register :orr, Or
      register :tee, Tee
      register :to, To
      register :try, Try
      register :use, Use
      register :validate, Validate
    end
  end
end
