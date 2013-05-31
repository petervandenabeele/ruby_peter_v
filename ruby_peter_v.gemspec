# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_peter_v/version'

Gem::Specification.new do |gem|
  gem.name          = "ruby_peter_v"
  gem.version       = RubyPeterV::VERSION
  gem.authors       = ["Peter Vandenabeele"]
  gem.email         = ["peter@vandenabeele.com"]
  gem.description   = %q{Ruby helpers for @peter_v}
  gem.summary       = %q{Ruby helpers for @peter_v}
  gem.homepage      = "https://github.com/petervandenabeele/ruby_peter_v"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec', '>= 2'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rb-fsevent', '~> 0.9'
  gem.add_development_dependency 'terminal-notifier-guard'
end
