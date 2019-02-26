lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "numo/sparse/version"

Gem::Specification.new do |spec|
  spec.name          = "numo-sparse"
  spec.version       = Numo::Sparse::VERSION
  spec.authors       = ["Kenta Murata"]
  spec.email         = ["mrkn@mrkn.jp"]

  spec.summary       = %q{Numo::Sparse}
  spec.description   = %q{Sparse tensor library for Ruby}
  spec.homepage      = "https://github.com/mrkn/numo-sparse"
  spec.license       = "MIT"
  spec.required_ruby_version = '~> 2.4'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "numo-narray"

  spec.add_development_dependency "bundler", ">= 1.17"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
end
