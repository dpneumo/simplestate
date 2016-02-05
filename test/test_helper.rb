$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
require 'simplestate'

require 'minitest/autorun'

require 'coveralls'
Coveralls.wear!

# Uncomment these to make pry available
# Also make necessary changes in simplestate.gemspec
#require 'pry'
#require 'pry-byebug'
