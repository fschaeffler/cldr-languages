# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cldr/languages/version'

Gem::Specification.new do |spec|
  spec.name          = "cldr-languages"
  spec.version       = Cldr::Languages::VERSION
  spec.authors       = ["Florian Schäffler"]
  spec.email         = ["ruby@schf.de"]
  spec.summary       = %q{Localization of languages to a given language or its own language}
  spec.description   = %q{Use language code 'zzx' for getting languages in its own language}
  spec.homepage      = "http://www.schf.de"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 0"
end
