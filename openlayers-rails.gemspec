$:.push File.expand_path('../lib', __FILE__)
require 'openlayers/rails/version'

Gem::Specification.new do |s|
  s.name          = "openlayers-rails"
  s.version       = OpenLayers::Rails::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors       = ["Devin Brown"]
  s.email          = ["devin.g.brown@gmail.com"]
  s.summary      = %q{OpenLayers toolkit for Rails 3.1 Asset Pipeline}
  s.description   = %q{openlayer-rails gem integrates OpenLayers rails toolkit for Rails 3.1 Asset Pipeline}

  s.files = Dir["lib/**/*"] + Dir["vendor/**/*"]  # + Dir["app/**/*"]
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "railties", "~> 3.1"
  s.add_development_dependency 'rails', '>= 3.1'
end