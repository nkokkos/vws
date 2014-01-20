# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vws/version'

Gem::Specification.new do |spec|
  spec.name          = "vws"
  spec.version       = Vws::VERSION
  spec.authors       = ["Nick Kokkos"]
  spec.email         = ["nkokkos@gmail.com"]
  spec.description   = %q{a gem to interact with Vuforia web services api}
  spec.summary       = %q{Web service gem}
  spec.homepage      = "http://github.com/nkokkos/vws"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  #development depedencies
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", ">= 10"
  spec.add_development_dependency "rspec",">=2"
  #spec.add_development_dependency "json","~> 1.8"

  #runtime dependencies
  spec.add_runtime_dependency "rest-client", "~> 1.6"
  spec.add_runtime_dependency "json", "~> 1.8"
end
