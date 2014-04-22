$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "token_for/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "token_for"
  s.version     = TokenFor::VERSION
  s.authors     = ["Janusz Pietrzyk"]
  s.homepage    = "http://github.com/Metallord/token_for"
  s.summary     = "Uses Rails 4.1's verifiers to provide stateless token functionality."
  s.description = "Uses Rails 4.1's verifiers to provide stateless token functionality."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.0"

  s.add_development_dependency "pg"
end
