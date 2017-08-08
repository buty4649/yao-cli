# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yao/cli/version"

Gem::Specification.new do |spec|
  spec.name          = "yao-cli"
  spec.version       = Yao::Cli::VERSION
  spec.authors       = ["Yuki Koya"]
  spec.email         = ["buty4649@gmail.com"]

  spec.summary       = %q{CLI tool of yao.}
  spec.description   = %q{CLI tool of yao.}
  spec.homepage      = "https://github.com/buty4649/yao-cli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "yao", ">= 0.3.6"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
