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

  def test_can_hold_previous_states
    ps1 = State.new(@state_holder, nil)
    @state.push_previous_state ps1
    assert_equal [ps1], @state.previous_states
  end

  def test_chain_of_previous_states_is_limited_to_one
    ps1 = State.new(@state_holder, nil)
    ps1.push_previous_state nil
    ps2 = State.new(@state_holder, ps1.class)
    ps2.push_previous_state ps1
    ps3 = State.new(@state_holder, ps2.class)
    ps3.push_previous_state ps2
    cs  = State.new(@state_holder, ps3.class)
    cs.push_previous_state ps3
    assert_equal 1, cs.previous_states.size
    assert_equal ps3, cs.previous_states.last
  end

end
