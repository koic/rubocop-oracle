# RuboCop Oracle

[![Gem Version](https://badge.fury.io/rb/rubocop-oracle.svg)](https://badge.fury.io/rb/rubocop-oracle)
[![CircleCI](https://circleci.com/gh/koic/rubocop-oracle.svg?style=svg)](https://circleci.com/gh/koic/rubocop-oracle)

A [RuboCop](https://github.com/rubocop-hq/rubocop) extension for [Active Record Oracle enhanced adapter](https://github.com/rsim/oracle-enhanced).

## Installation

Just install the `rubocop-oracle` gem

```sh
gem install rubocop-oracle
```

or if you use bundler put this in your `Gemfile`

```ruby
gem 'rubocop-oracle'
```

## Cops

This gem contains `Oracle/OnlineIndex` cop to check if indexing is possible without stopping Rails application' service using Oracle.
The cop supports safe migration for your production environment.

### `Oracle/OnlineIndex` cop

This cop checks for uses `options: online` option on `add_index`.
The `ONLINE` option is required if you want to run with OLTP when indexing migration in Oracle.

```ruby
# bad
add_index :table_name, :column_name

# good
add_index :table_name, :column_name, options: :online
```

By specifying `MigratedSchemaVersion` option, migration files that have been migrated can be ignored.

```yaml
# .rubocop.yml
Oracle/OnlineIndex:
  MigratedSchemaVersion: '202104130150' # Migration files lower than or equal to '202104130150' will be ignored.
```

This prevents detection of migration files that have already been applied to the production environment.

## Usage

You need to tell RuboCop to load the Oracle extension. There are three
ways to do this:

### RuboCop configuration file

Put this into your `.rubocop.yml`.

```yaml
require: rubocop-oracle
```

Alternatively, use the following array notation when specifying multiple extensions.

```yaml
require:
  - rubocop-other-extension
  - rubocop-oracle
```

Now you can run `rubocop` and it will automatically load the RuboCop Oracle
cops together with the standard cops.

### Command line

```sh
rubocop --require rubocop-oracle
```

### Rake task

```ruby
RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-oracle'
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/koic/rubocop-oracle.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
