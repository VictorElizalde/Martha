# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'martha/version'

Gem::Specification.new do |spec|
  spec.name          = 'martha'
  spec.version       = Martha::VERSION
  spec.authors       = ['Victor Elizalde', 'Mauricio Cortes', 'Oscar Michel']
  spec.email         = ['vic-bull@hotmail.com']

  spec.summary       = 'A ruby gem to dockerize applications.'
  spec.description   = 'A ruby gem to dockerize applications.'
  spec.homepage      = 'https://github.com/VictorElizalde/Martha'
  spec.license       = 'MIT'

  # spec.files = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = 'bin'
  spec.executables   = ['martha']
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'reek'

  spec.add_dependency 'thor'
end
