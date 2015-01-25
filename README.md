# toy #

[![Gem Version](https://badge.fury.io/rb/toy.svg)](http://badge.fury.io/rb/toy)
[![Build Status](https://travis-ci.org/rubyengineer/toy.svg?branch=master)](https://travis-ci.org/rubyengineer/toy)
[![Code Climate](https://codeclimate.com/github/rubyengineer/toy/badges/gpa.svg)](https://codeclimate.com/github/rubyengineer/toy)
[![Test Coverage](https://codeclimate.com/github/rubyengineer/toy/badges/coverage.svg)](https://codeclimate.com/github/rubyengineer/toy)
[![Dependency Status](https://gemnasium.com/rubyengineer/toy.svg)](https://gemnasium.com/rubyengineer/toy)

Simulation of a toy robot moving on a square tabletop. The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed. Multiple robots should be able to roam around the surface of the same table.

## Install ##
```bash
$ gem install toy
```

## Examples ##
```ruby
require 'toy'
```

### Copyright ###
Copyright (c) 2015 Ninoslav Milenovic

See LICENSE.txt for details.
