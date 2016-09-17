require 'test_helper'
require 'interface/state_interface_test'

class NullStateTest < Minitest::Test
  def setup
    @state = NullState.new(holder: DummyStateHolder.new)
  end

  include StateInterfaceTest

  def test_name_returns_the_state_name_as_a_string
    assert_equal 'NullState', @state.name
  end

  def test_name_returns_the_symbolized_state_name
    assert_equal :NullState, @state.symbol
  end
end
