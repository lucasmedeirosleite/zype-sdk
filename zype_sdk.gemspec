# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zype_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'ZypeSDK'
  spec.version       = ZypeSDK::VERSION
  spec.authors       = ['Lucas Medeiros']
  spec.email         = ['lucastoc@gmail.com']

  spec.summary       = %q{Zype SDK gem}
  spec.description   = %q{A wrapper to the Zype Web API}
  spec.homepage      = "https://github.com/lucasmedeirosleite/zype-sdk"
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
