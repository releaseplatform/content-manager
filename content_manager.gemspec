$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "content_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "content_manager"
  s.version     = ContentManager::VERSION
  s.authors     = ["Jasper Lyons"]
  s.email       = ["jasper.lyons@gmail.com"]
  s.homepage    = "http://content-manager.github.io"
  s.summary     = "A super light weight, content manager for developers."
  s.description = "Define groups of content, views, and versions of that content that can be swapped out at runtime. The driving force behind this was allowing customers to be able to update the copy on their pages and for us to A/B test versions fo that copy for them."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "jquery-rails"
  s.add_dependency "rails", ">= 4.2"

  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "jquery-ui-rails"
  s.add_development_dependency "sqlite3"
end
