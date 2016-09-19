require 'test_helper'
require 'interface/state_interface_test'

class StateTest < Minitest::Test
  def setup
    @state = State.new(holder: DummyStateHolder.new)
  end

  include StateInterfaceTest

  def test_State_does_not_implement_name_and_raises_an_informative_error
    err = assert_raises(NotImplementedError) { @state.__send__(:name) }
    assert_equal "#name was called on an instance of State either directly or via super.", err.message
  end

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
    assert_equal 'New State', @state.holder.current_state
  end

  def test_a_State_descendant_can_symbolize_its_name
    descendant = Descendant.new(holder: DummyStateHolder.new)
    assert_equal :Descendant, descendant.symbol
  end
end

class Descendant < State
  def name; 'Descendant'; end
  private
  def enter; end
  def exit; end
end
