# RuboCop Oracle

[![Gem Version](https://badge.fury.io/rb/rubocop-faker.svg)](https://badge.fury.io/rb/rubocop-oracle)
[![CircleCI](https://circleci.com/gh/koic/rubocop-faker.svg?style=svg)](https://circleci.com/gh/koic/rubocop-oracle)

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

## Usage

You need to tell RuboCop to load the Rails extension. There are three
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

Now you can run `rubocop` and it will automatically load the RuboCop Rails
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
