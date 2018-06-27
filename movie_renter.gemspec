
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "movie_renter/version"

Gem::Specification.new do |spec|
  spec.name          = "movie_renter"
  spec.version       = MovieRenter::VERSION
  spec.authors       = ["Tiago Parreira"]
  spec.email         = ["parreirat@gmail.com"]

  spec.summary       = "MovieRenter gem for mobileJob challenge."
  spec.description   = "MovieRenter gem for mobileJob challenge."
  spec.homepage      = "https://github.com/parreirat/mobilejob_challenge"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Bundler, what else?
  spec.add_development_dependency "bundler"

  # For proper and pretty debugging.
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pry-doc"
  spec.add_development_dependency "awesome_print"

  # Code linting is always nice.
  spec.add_development_dependency "rubocop"

  # We love tests!
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"

end
