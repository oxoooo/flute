# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flute/version'

Gem::Specification.new do |spec|
  spec.name          = "flute"
  spec.version       = Flute::VERSION
  spec.authors       = ["manjia\n"]
  spec.email         = ["tywf91@gmail.com"]

  spec.summary       = %q{一个简单的网络爬虫框架.}
  spec.description   = %q{一个简单的网络爬虫框架.}
  spec.homepage      = "https://github.com/oxoooo/flute"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir      = "exe"
  spec.executables = ["flute"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'activesupport', '~> 5.0.1'
  spec.add_dependency 'typhoeus', '~> 1.1.2'
  spec.add_dependency 'nokogiri', '~> 1.7.0'
  spec.add_dependency 'thor'

end
