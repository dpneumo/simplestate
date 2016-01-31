require 'test_helper'
require 'dummys/button'

class SimplestateTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Simplestate::VERSION
  end

  include Button

  def setup
    @button = Button.new(initial_state_class: Off, color: 'Red')
    # Alternate syntax
    # @button = Button.new(start_in: Off, color: 'Red')
  end

  def test_initial_button_state_is_set
    assert_equal 'Off', @button.current_state.name
    assert_equal  NilState,  @button.previous_state_class
  end

  def test_single_button_press
    @button.press
    expected = [ "Entered the Off state", "Exited the Off state",
                 "Entered the On state", "Button is on"]
    assert_equal expected, @button.messages
    assert_equal Off, @button.previous_state_class
  end

  def test_double_button_press
    @button.press
    @button.press
    expected = [ "Entered the Off state", "Exited the Off state",
                 "Entered the On state",  "Button is on", "Exited the On state",
                 "Entered the Off state", "Button is off" ]
    assert_equal expected, @button.messages
    assert_equal On, @button.previous_state_class
  end

  def test_a_button_does_not_respond_to_enter
    assert_equal false, @button.respond_to?(:enter)
  end

  def test_a_button_does_not_respond_to_exit
    assert_equal false, @button.respond_to?(:exit)
  end

  def test_a_button_does_not_respond_to_a_private_method
    assert_equal false, @button.respond_to?(:private_method)
  end

  def test_a_button_responds_to_press
    assert_equal true, @button.respond_to?(:press)
  end

  def test_raises_NoMethodError_
    assert_equal false, @button.respond_to?(:private_method)
  end

  def test_a_button_method_overrides_state_method_of_same_name
    assert_equal 'Button', @button.name
  end

  def test_a_button_knows_its_previous_states
    assert_equal NilState, @button.previous_states.last.class
    @button.press
    assert_equal Off, @button.previous_states.last.class
    @button.press
    assert_equal On, @button.previous_states.last.class
  end

  def test_a_buttons_previous_states_list_depth_limited_to_one
    @button.press
    @button.press
    @button.press
    assert_equal 1, @button.previous_states.size
  end

  def test_a_button_returns_its_last_prior_state
    @button.press # Curr state: On,  Prior state: Off
    @button.press # Curr state: Off, Prior state: On
    assert_equal On, @button.prior_state
  end
end
