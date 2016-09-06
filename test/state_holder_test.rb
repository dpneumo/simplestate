require 'test_helper'
require 'interface/state_holder_interface_test'

class State1 < State
  def name;  'State1'; end
  private
    def enter; 'enter'; end
    def exit;  'exit';  end
end

class State2 < State
  def name;  'State2'; end
  private
    def enter; 'State2 enter method called'; end
    def exit;  'State2 exit method called';  end
end

class StateHolderTest < Minitest::Test
  def setup
    @state_holder = StateHolder.new(initial_state: :State1)
    @st_1 = State1.new(holder: @state_holder)
    @st_2 = State2.new(holder: @state_holder)
    @state_holder.start
  end

  include StateHolderInterfaceTest

  def test_creation_requires_initial_state_argument
    assert_raises(ArgumentError) { StateHolder.new }
  end

  def test_creation_sets_initial_state
    assert_equal :State1, @state_holder.current_state.symbol
  end

  def test_can_transition_to_new_state
    expect = 'State2 enter method called'
    assert_equal expect, @state_holder.transition_to(:State2)
    expect = :State2
    assert_equal expect,  @state_holder.current_state.symbol
  end

  def test_initializes_state_history_to_NullState
    assert_equal :NullState, @state_holder.history.last
  end

  def test_updates_state_history_on_state_transition
    @state_holder.transition_to(:State2)
    assert_equal 2, @state_holder.history.size
    assert_equal :NullState, @state_holder.history[0]
    assert_equal :State1, @state_holder.history[1]
  end
end

