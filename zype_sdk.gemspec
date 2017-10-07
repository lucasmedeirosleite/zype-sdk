# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zype_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'zype_sdk'
  spec.version       = ZypeSDK::VERSION
  spec.authors       = ['Lucas Medeiros']
  spec.email         = ['lucastoc@gmail.com']

  spec.summary       = %(Zype SDK gem)
  spec.description   = %(A wrapper to the Zype Web API)
  spec.homepage      = 'https://github.com/lucasmedeirosleite/zype-sdk'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'caze', '~> 0.2.1'
  spec.add_dependency 'httparty', '~> 0.15.6'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'coveralls', '~> 0.8.21'
  spec.add_development_dependency 'dotenv', '~> 2.2', '>= 2.2.1'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.50.0'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.3'
  spec.add_development_dependency 'webmock', '~> 3.0', '>= 3.0.1'
end
