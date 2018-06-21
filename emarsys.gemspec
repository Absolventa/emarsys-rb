# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emarsys/version'

Gem::Specification.new do |spec|
  spec.name          = "emarsys"
  spec.version       = Emarsys::VERSION
  spec.authors       = ["Daniel Schoppmann"]
  spec.email         = ["daniel.schoppmann@absolventa.de"]
  spec.description   = %q{A Ruby library for interacting with the Emarsys API.}
  spec.summary       = %q{Easy to use ruby library for Emarsys Marketing Suite.}
  spec.homepage      = "https://github.com/Absolventa/emarsys-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.5.0"
  spec.add_development_dependency "webmock", "< 2.0"
  spec.add_development_dependency "timecop"
end
