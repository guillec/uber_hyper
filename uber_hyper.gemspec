# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uber_hyper/version'

Gem::Specification.new do |spec|
  spec.name          = "uber_hyper"
  spec.version       = UberHyper::VERSION
  spec.authors       = ["Guille Carlos"]
  spec.email         = ["guille@bitpop.in"]
  spec.description   = %q{Client Uber Hypermedia}
  spec.summary       = %q{Client for the application/vnd.amundsen-uber+xml, application/vnd.amundsen-uber+json media type}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
