require 'test_helper'

class ButtonTest < Minitest::Test
  def setup
    @button = Button.new( opts: {name: 'Launch'})
    On.new(holder: @button, opts: {logger: NullLogger.new})
    Off.new(holder: @button, opts: {logger: NullLogger.new})
    @button.start(:Off)
  end

  def test_initial_button_state_is_set
    assert_equal :Off, @button.current_state.symbol
    assert_equal :NullState,  @button.prior_state
  end

  def test_single_button_press
    @button.press
    assert_equal :Off, @button.prior_state
  end

  def test_double_button_press
    @button.press # Curr state: 'On',  Prior state: 'Off'
    @button.press # Curr state: 'Off', Prior state: 'On'
    assert_equal :On, @button.prior_state
  end

  def test_a_button_does_not_respond_to_enter
    assert_equal false, @button.respond_to?(:enter)
  end

  def test_a_button_does_not_respond_to_exit
    assert_equal false, @button.respond_to?(:exit)
  end

  def test_a_button_method_overrides_state_method_of_same_name
    assert_equal 'Launch', @button.name
  end

  def test_a_button_stores_previous_state_history
    15.times { @button.press }
    hsl = @button.hx_size_limit
    assert_equal hsl, @button.history.size
  end

  def test_the_default_history_size_is_10
    assert_equal 10, @button.hx_size_limit
  end
end

class NullLogger
  def info(txt)
  end
end

