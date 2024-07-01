# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/grape/version'

Gem::Specification.new do |spec|
  spec.name          = "wt-rspec-grape"
  spec.version       = Rspec::Grape::VERSION
  spec.authors       = ["Ivan Tarapon"]
  spec.email         = ["ivan.tarapon@wetravel.com"]

  spec.summary       = %q{A set of helpers, which make grape api specs shorter.}
  spec.homepage      = "https://github.com/wetravel-com/rspec-grape"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rack-test", "~> 2.0"
  spec.add_runtime_dependency "rspec-core", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "grape"
end
