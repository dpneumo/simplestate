require 'test_helper'
require 'state_holder_interface_test'

class State1 < State
  def enter; 'enter'; end
  def exit;  'exit';  end
end

class State2 < State
  def enter; 'enter'; end
  def exit;  'exit';  end
end

class StateHolderTest < Minitest::Test
  def setup
    @state_holder = StateHolder.new(initial_state_class: State1)
  end

  include StateHolderInterfaceTest

  def test_creation_requires_initial_state_class_specification
    assert_raises(NoMethodError) { StateHolder.new }
  end

  def test_creation_sets_initial_state
    assert_equal State1, @state_holder.current_state.class
  end

  def test_alternate_initial_state_specification_in_creation
    sh_alt = StateHolder.new(start_in: State2)
    assert_equal State2, sh_alt.current_state.class
  end

  def test_can_set_a_new_state
    @state_holder.set_new_state(State2)
    assert_equal State2, @state_holder.current_state.class
    assert_equal @state_holder, @state_holder.current_state.holder
    assert_equal State1, @state_holder.current_state.previous_state_class
  end

  def test_can_transition_to
    assert_equal 'enter', @state_holder.transition_to(State2)
    assert_equal State2,  @state_holder.current_state.class
  end
end

