require 'test_helper'
require 'state_interface_test'
require 'dummys/dummy_state'

class DummyStateTest < Minitest::Test
  def setup
    @state_holder = DummyStateHolder.new
    @state = DummyState.new(@state_holder, nil)
  end

  include StateInterfaceTest
end
