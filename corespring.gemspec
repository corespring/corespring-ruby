# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "corespring/version"

Gem::Specification.new do |s|
  s.name        = "corespring"
  s.version     = CoreSpring::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Burton"]
  s.email       = ["developers@corespring.org"]
  s.homepage    = "https://github.com/corespring/corespring-ruby"
  s.summary     = %q{CoreSpring API Client}
  s.description = %q{CoreSpring API wrapper}

  s.rubyforge_project = "corespring"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ['corespring']
  s.require_paths = ["lib"]

  s.add_dependency "builder", ">= 2.1.2"
  s.add_dependency "httparty", ">= 0.8"

  {
    'rake'    => '~> 0.8.7',
    'rspec'   => '~> 2.12',
    'webmock' => '~> 1.6.2'
  }.each { |l, v| s. add_development_dependency l, v }
end
