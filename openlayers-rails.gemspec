# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openlayer/rails/version'

Gem::Specification.new do |gem|
  gem.name          = "openlayers-rails"
  gem.version       = Openlayers::Rails::VERSION
  gem.authors       = ["Devin Brown", "Toms Mikoss"]
  gem.email          = ["devin.g.brown@gmail.com", "toms.mikoss@gmail.com"]
  gem.description   = %q{OpenLayers library packaged for easy inclusion in Ruby on Rails asset pipeline.}
  gem.summary       = gem.description

  gem.add_dependency             'railties',   '>= 3.1'
  gem.files = Dir["lib/**/*"] + Dir["vendor/**/*"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "railties", "~> 3.1"
end
