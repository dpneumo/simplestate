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
    assert_equal  nil,  @button.previous_state_class
  end

  def test_single_button_press
    @button.press
    expected = ["Exited the Off state", "Entered the On state", "Button is on"]
    assert_equal expected, @button.messages
    assert_equal Off, @button.previous_state_class
  end

  def test_double_button_press
    @button.press
    @button.press
    expected = [ "Exited the Off state",
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
end
