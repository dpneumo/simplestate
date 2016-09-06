require 'test_helper'
require 'state_interface_test'

class StateTest < Minitest::Test
  def setup
    @state_holder = DummyStateHolder.new
    @state = State.new(holder: @state_holder)
  end

  include StateInterfaceTest

  def test_State_does_not_implement_enter_and_raises_an_informative_error
    err = assert_raises(NotImplementedError) { @state.__send__(:enter) }
    assert_equal "#enter was called on an instance of State either directly or via super.", err.message
  end

  def test_State_does_not_implement_exit_and_raises_an_informative_error
    err = assert_raises(NotImplementedError) { @state.__send__(:exit) }
    assert_equal "#exit was called on an instance of State either directly or via super.", err.message
  end

  def test_transition_to_calls_state_holder_transition_to
    @state.__send__(:transition_to, 'New State' )
    assert_equal 'New State', @state_holder.current_state
  end
end
