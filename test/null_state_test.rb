require 'test_helper'
require 'state_interface_test'
require_relative '../lib/simplestate/null_state'

class NullStateTest < Minitest::Test
  def setup
    @state = NullState.new
  end

  include StateInterfaceTest
end
