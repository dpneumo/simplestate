# Testing StateHolder using the legacy signatures for #new and #start
require 'test_helper'

class LegacyShTest < Minitest::Test
  def setup
    @sh_legacy = StateHolder.new(initial_state: :State1)
    State1.new(holder: @sh_legacy)
    State2.new(holder: @sh_legacy)
    @sh_legacy.start(:State1)
  end

  def test_creation_initializes_current_state_to_initial_state
    assert_equal :State1, @sh_legacy.current_state.symbol
  end

  def test_can_transition_to_new_state
    expect = 'State2 enter method called'
    assert_equal expect, @sh_legacy.transition_to(:State2)
    expect = :State2
    assert_equal expect,  @sh_legacy.current_state.symbol
  end

  def test_initializes_state_history
    assert_equal [:State1], @sh_legacy.history
  end

  def test_updates_state_history_on_state_transition
    @sh_legacy.transition_to(:State2)
    assert_equal [:State1, :State2], @sh_legacy.history
  end
end

