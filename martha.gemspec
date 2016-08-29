# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'martha/version'

Gem::Specification.new do |spec|
  spec.name          = 'martha'
  spec.version       = Martha::VERSION
  spec.authors       = ['Victor Elizalde', 'Mauricio Cortes', 'Oscar Michel']
  spec.email         = ['vic-bull@hotmail.com', 'abmaury97@hotmail.com', 'oscarmichelh@gmail.com']
  spec.summary       = 'A ruby gem to document code (Check github repo for specifications)'
  spec.description   = 'A ruby gem to document code (Check github repo for specifications).'
  spec.homepage      = 'https://github.com/VictorElizalde/Martha'
  spec.license       = 'MIT'
  spec.executables << 'martha'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = 'bin'
  spec.executables   = ['martha']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #  raise 'RubyGems 2.0 or newer is required to \
  #        protect against public gem pushes.'
  # end

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'reek'
  spec.add_dependency 'thor'
end
