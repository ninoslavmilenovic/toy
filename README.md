# toy #

[![Gem Version](https://badge.fury.io/rb/toy.svg)](http://badge.fury.io/rb/toy)
[![Build Status](https://travis-ci.org/rubyengineer/toy.svg?branch=master)](https://travis-ci.org/rubyengineer/toy)
[![Code Climate](https://codeclimate.com/github/rubyengineer/toy/badges/gpa.svg)](https://codeclimate.com/github/rubyengineer/toy)
[![Test Coverage](https://codeclimate.com/github/rubyengineer/toy/badges/coverage.svg)](https://codeclimate.com/github/rubyengineer/toy)
[![Dependency Status](https://gemnasium.com/rubyengineer/toy.svg)](https://gemnasium.com/rubyengineer/toy)

Simulation of a toy robot moving on a square tabletop. The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

## Install ##
```bash
$ gem install toy
```

## Usage ##
```bash
$ toy
```

## Examples ##

Example Input and Output:  

a)  
`PLACE 0,0,NORTH`  
`MOVE`  
`REPORT`  
Output: `0,1,NORTH`  

b)  
`PLACE 0,0,NORTH`  
`LEFT`  
`REPORT`  
Output: `0,0,WEST`  

c)  
`PLACE 1,2,EAST`  
`MOVE`  
`MOVE`  
`LEFT`  
`MOVE`  
`REPORT`  
Output: `3,3,NORTH`

### Copyright ###
Copyright (c) 2015 Ninoslav Milenovic

See LICENSE.txt for details.
