require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

gem 'rspec', '~> 3.1'
require 'rspec'
require 'toy'

include Toy
