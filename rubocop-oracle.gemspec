# frozen_string_literal: true

require_relative 'lib/rubocop/oracle/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-oracle'
  spec.version       = RuboCop::Oracle::VERSION
  spec.authors       = ['Koichi ITO']
  spec.email         = ['koic.ito@gmail.com']

  spec.summary       = 'A RuboCop extension for Active Record Oracle enhanced adapter.'
  spec.description   = 'A RuboCop extension for Active Record Oracle enhanced adapter.'
  spec.homepage      = 'https://github.com/koic/rubocop-oracle'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rubocop', '~> 1.0'
end
