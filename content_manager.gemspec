$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "content_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "content_manager"
  s.version     = ContentManager::VERSION
  s.authors     = ["Jasper Lyons"]
  s.email       = ["jasper.lyons@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ContentManager."
  s.description = "TODO: Description of ContentManager."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "jquery-rails"
  s.add_dependency "rails", "~> 4.2.5.1"

  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "jquery-ui-rails"
  s.add_development_dependency "sqlite3"
end
