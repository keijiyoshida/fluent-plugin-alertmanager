# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/alertmanager/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-alertmanager"
  spec.version       = Fluent::Plugin::Alertmanager::VERSION
  spec.authors       = ["Keiji Yoshida"]
  spec.email         = ["keijiyoshida.mail@gmail.com"]

  spec.summary       = "fluent-plugin-alertmanager"
  spec.description   = "fluent-plugin-alertmanager"
  spec.homepage      = "https://github.com/keijiyoshida/fluent-plugin-alertmanager"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
