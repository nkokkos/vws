# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vws/version'

Gem::Specification.new do |spec|
  spec.name          = "vws"
  spec.version       = Vws::VERSION
  spec.authors       = ["Nick Kokkos"]
  spec.email         = ["nkokkos@gmail.com"]
  spec.description   = %q{Vuforia web services api gem}
  spec.summary       = %q{This is a ruby gem that interacts with Vuforia Web service API for Cloud database management. It uses the rest-client gem to handle the http/rest requests needed}
  spec.homepage      = "http://github.com/nkokkos/vws"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  #development depedencies
  spec.add_development_dependency "bundler", "~> 1.9.1"
  spec.add_development_dependency "rake", "~> 10.4.2"
  spec.add_development_dependency "rspec","~> 3.2.0"
  #spec.add_development_dependency "json","~> 1.8"

  #runtime dependencies
  spec.add_runtime_dependency "rest-client", "~> 2.0.2"
  spec.add_runtime_dependency "json", "~> 1.8"
end
