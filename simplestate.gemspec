# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplestate/version'

Gem::Specification.new do |spec|
  spec.name          = "simplestate"
  spec.version       = Simplestate::VERSION
  spec.authors       = ["Mitchell C Kuppinger"]
  spec.email         = ["dpneumo@gmail.com"]

  spec.summary       = %q{A SimpleDelegator based implementation of the State Pattern}
  spec.description   = %q{Provides a base State class and a subclassed SimpleDelegator modified to provide state pattern support.}
  spec.homepage      = "https://github.com/dpneumo/simplestate"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  # Uncomment these to make pry available in testing
  # Also make necessary changes in test_helper.rb
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
end
