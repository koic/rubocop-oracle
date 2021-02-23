# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/oracle'
require_relative 'rubocop/oracle/version'
require_relative 'rubocop/oracle/inject'

RuboCop::Oracle::Inject.defaults!

require_relative 'rubocop/cop/oracle_cops'
