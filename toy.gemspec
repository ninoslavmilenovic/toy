# -*- encoding: utf-8 -*-

require File.expand_path('../lib/toy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'toy'
  gem.version       = Toy::VERSION
  gem.summary       = %q{Summary}
  gem.description   = %q{Description}
  gem.license       = 'MIT'
  gem.authors       = ['Ninoslav Milenovic']
  gem.email         = 'coffee@rubyengineer.com'
  gem.homepage      = 'https://github.com/rubyengineer/toy#readme'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rdoc', '~> 4.1'
  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'codeclimate-test-reporter'
end
