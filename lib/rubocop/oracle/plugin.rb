# frozen_string_literal: true

require 'lint_roller'

module RuboCop
  module Oracle
    # A plugin that integrates RuboCop Oracle with RuboCop's plugin system.
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: 'rubocop-oracle',
          version: VERSION,
          homepage: 'https://github.com/koic/rubocop-oracle',
          description: 'A RuboCop extension for Active Record Oracle enhanced adapter.'
        )
      end

      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: Pathname.new(__dir__).join('../../../config/default.yml')
        )
      end
    end
  end
end
