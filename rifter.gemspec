# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rifter/version'

Gem::Specification.new do |spec|
  spec.name          = 'rifter'
  spec.version       = Rifter::VERSION
  spec.authors       = ['Jakub Głuszecki']
  spec.email         = ['jakub.gluszecki@gmail.com']

  spec.summary       = 'Ship Fitting Engine for Eve Online'
  # spec.description   = 'Ship Fitting Engine for Eve Online'
  spec.homepage      = 'https://github.com/cthulhu666/rifter'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ice_nine', '~> 0.11'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'sqlite3'
  spec.add_dependency 'sequel'
  spec.add_dependency 'deterministic'

  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
end
