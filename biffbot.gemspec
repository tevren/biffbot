# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'biffbot/version'

Gem::Specification.new do |gem|
  gem.name          = "biffbot"
  gem.version       = Biffbot::VERSION
  gem.authors       = ["Anurag Mohanty"]
  gem.email         = ["anurag@columbia.edu"]
  gem.description   = "Ruby gem to connect to diffbot's article api"
  gem.summary       = "Given a url, pulls article content using diffbot's article extractor"
  gem.homepage      = "https://github.com/tevren/biffbot"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency("httparty")
end
