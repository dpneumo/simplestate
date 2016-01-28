require 'test_helper'

class StateTest < Minitest::Test
  def setup
    @state_holder = DummyStateHolder.new
    @state = State.new(@state_holder, nil)
  end

  include StateInterfaceTest

  def test_State_does_not_implement_enter
    assert_raises(RuntimeError) { @state.send(:enter) }
  end

  def test_State_does_not_implement_exit
    assert_raises(RuntimeError) { @state.send(:exit) }
  end

  def test_transition_to_calls_state_holder_transition_to
    @state.send(:transition_to, 'New State' )
    assert_equal 'New State', @state_holder.current_state
  end

end
