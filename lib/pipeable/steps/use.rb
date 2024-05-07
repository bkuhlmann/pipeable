# frozen_string_literal: true

module Pipeable
  module Steps
    # Messages a command (or pipe) which answers a result.
    class Use < Abstract
      def initialize(command, **)
        super(**)
        @command = command
      end

      def call(result) = result.bind { |input| command.call input }

      private

      attr_reader :command
    end
  end
end
