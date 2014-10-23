$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sharing_counter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sharing_counter"
  s.version     = SharingCounter::VERSION
  s.authors     = ["Tolia Demidov"]
  s.email       = ["toliademidov@gmail.com"]
  s.homepage    = "github.com/Tolia"
  s.summary     = "TODO: Summary of SharingCounter."
  s.description = "TODO: Description of SharingCounter."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency 'rspec'
  s.add_development_dependency "webmock"

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'multi_json'
  s.add_runtime_dependency 'faraday'

end
