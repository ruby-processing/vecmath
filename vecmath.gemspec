
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vecmath/version"

Gem::Specification.new do |spec|
  spec.name          = "vecmath"
  spec.version       = Vecmath::VERSION
  spec.authors       = ["Martin Prout"]
  spec.email         = ["mamba2928@yahoo.co.uk"]

  spec.summary       = %q{Provides Vec2D and Vec3D funtionality.}
  spec.description   = %q{Vec3D and Vec3D ruby classes are written in java.}
  spec.licenses     = %w(GPL-3.0 LGPL-2.0)
  spec.homepage      = 'https://ruby-processing.github.io/'
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.files << 'lib/vecmath.jar'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
