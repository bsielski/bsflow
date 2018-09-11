
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "c_flow/version"

Gem::Specification.new do |spec|
  spec.name          = "bsielski_control_flow"
  spec.version       = CFlow::VERSION
  spec.authors       = ["Bart\xC5\x82omiej Sielski"]
  spec.email         = ["b.sielski@yandex.com"]

  spec.summary       = %q{A couple of classes for organizing objects in simple data flow structures (conditional loops, pipelines etc.}
  spec.homepage      = "https://github.com/bsielski/bsielski_control_flow"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "bsielski_value_generator"
end
