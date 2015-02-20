# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'triviacrack/client/version'

Gem::Specification.new do |spec|
  spec.name          = "triviacrack-client"
  spec.version       = TriviaCrack::Client::VERSION
  spec.authors       = ["David Kus"]
  spec.email         = ["david@kus.dk"]
  spec.summary       = %q{Trivia Crack CLI client.}
  spec.description   = %q{Trivia Crack client for the command line.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["trivia-crack"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"

  spec.add_dependency "thor", "~> 0.19.1"
end
