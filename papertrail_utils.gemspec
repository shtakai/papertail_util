
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "papertrail_utils/version"

Gem::Specification.new do |spec|
  spec.name          = "papertrail_utils"
  spec.version       = PapertrailUtils::VERSION
  spec.authors       = ["Alyson T"]
  spec.email         = ["shtakai@gmail.com"]

  spec.summary       = %q{util for papertrail}
  spec.description   = %q{util for papertrail_utils}
  spec.homepage      = "https://www.github.com/shtakai"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "thor", "~> 0.20"
  spec.add_development_dependency "papertrail-cli"
  spec.add_development_dependency "col", "~> 1.0"
end
