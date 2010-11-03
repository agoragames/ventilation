require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fakeweb'
require 'mocha'
require 'action_controller'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'ventilation'

class Test::Unit::TestCase
end
