# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hexagonal/version'

Gem::Specification.new do |spec|
  spec.name          = 'hexagonal'
  spec.version       = Hexagonal::VERSION
  spec.authors       = ['Alpha Chen']
  spec.email         = %w[ alpha.chen@gmail.com ]
  spec.description   = ''
  spec.summary       = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w[ lib ]

  spec.add_development_dependency 'bundler', '~> 1.3'

  spec.add_development_dependency 'minitest', '~> 5.0.4'
  spec.add_development_dependency 'pry'

  # pinned because of https://github.com/jimweirich/rake/issues/198
  spec.add_development_dependency 'rake', '10.1.0.beta.3'
end
