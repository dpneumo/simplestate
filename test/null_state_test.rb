require 'test_helper'
require 'interface/state_interface_test'

class NullStateTest < Minitest::Test
  def setup
    @state = NullState.new(holder: DummyStateHolder.new)
  end

  include StateInterfaceTest
end
