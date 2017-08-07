# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "jekyll-extract"
  spec.version       = "0.1.0"
  spec.authors       = ["Ashwin Maroli"]
  spec.email         = ["ashmaroli@gmail.com"]

  spec.summary       = "Extract theme-gem contents to source directory."
  spec.homepage      = "https://github.com/ashmaroli/jekyll-extract"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r!^(lib/|(LICENSE|README)((\.(txt|md|markdown)|$)))!i)
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "jekyll", "~> 3.3"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rubocop", "~> 0.49.1"
end
