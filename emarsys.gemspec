# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emarsys/version'

Gem::Specification.new do |spec|
  spec.name = "emarsys"
  spec.version = Emarsys::VERSION
  spec.authors = ["Palatinate Tech"]
  spec.email = ["info@palatinategroup.com"]
  spec.description = %q{A Ruby library for interacting with the Emarsys API.}
  spec.summary = %q{Easy to use ruby library for Emarsys Marketing Suite.}
  spec.homepage = "https://github.com/ygt/emarsys-rb"
  spec.license = "MIT"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.pkg.github.com/ygt/emarsys-rb",
    "github_repo" => "ssh://github.com/ygt/emarsys-rb"
  }

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.3'

  spec.add_dependency "rest-client", "~> 2.1.0"

  spec.add_development_dependency "bundler", "~> 2.2.4"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_development_dependency "rspec", "~> 3.10.0"
  spec.add_development_dependency "webmock", "~> 3.14.0"
  spec.add_development_dependency "timecop", "~> 0.9.4"
end
