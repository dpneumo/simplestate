require 'test_helper'
require 'interface/state_interface_test'
require 'dummy/dummy_state'

class DummyStateTest < Minitest::Test
  def setup
    @state = DummyState.new(holder: DummyStateHolder.new)
  end

  include StateInterfaceTest
end
