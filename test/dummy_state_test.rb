require 'test_helper'
require 'interface/state_interface_test'
require 'dummys/dummy_state_holder'
require 'dummys/dummy_state'

class DummyStateTest < Minitest::Test
  def setup
    @state_holder = DummyStateHolder.new
    @state = DummyState.new(holder: @state_holder)
  end

  include StateInterfaceTest
end
