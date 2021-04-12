# frozen_string_literal: true

module RuboCop
  module Cop
    module Oracle
      #
      # This cop checks for uses `options: online` option on `add_index`.
      # The `ONLINE` option is required if you want to run with OLTP when indexing migration in Oracle.
      # By specifying `MigratedSchemaVersion` option, migration files that have been migrated can be ignored.
      #
      # @example
      #
      #   # bad
      #   add_index :table_name, :column_name
      #
      #   # good
      #   add_index :table_name, :column_name, options: :online
      #
      # @example MigratedSchemaVersion: '202104130150'
      #
      #   # bad - Migration files higher than '202104130150' will be registered an offense.
      #   add_index :table_name, :column_name
      #
      #   # good - Migration files lower than or equal to '202104130150' will be ignored.
      #   add_index :table_name, :column_name
      #
      class OnlineIndex < Base
        extend AutoCorrector

        MSG = 'Specify `options: :online` option to `add_index`.'
        RESTRICT_ON_SEND = %i[add_index].freeze

        def on_send(node)
          return if already_migrated_file? || use_online_option?(node.last_argument)

          add_offense(node.loc.selector) do |corrector|
            corrector.insert_after(node, ', options: :online')
          end
        end

        private

        def already_migrated_file?
          schema_version = File.basename(processed_source.file_path).match(/(?<timestamp>\d{12})/)['timestamp']
          return true unless migrated_schema_version

          schema_version <= migrated_schema_version # Ignore applied migration files.
        end

        def use_online_option?(options)
          if options.hash_type?
            options.each_pair do |key, value|
              return true if key.source.match?(/\A:?options\z/i) && value.source.match?(/\A:?online\z/i)
            end
          end

          false
        end

        def migrated_schema_version
          cop_config.fetch('MigratedSchemaVersion', nil)
        end
      end
    end
  end
end
