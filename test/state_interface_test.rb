module StateInterfaceTest
  def test_responds_to_holder
    assert_respond_to(@state, :holder)
  end

  def test_responds_to_previous_state
    assert_respond_to(@state, :previous_state)
  end

  def test_responds_to_pvt_methods_enter_and_exit
    prvt = true
    assert_equal true, @state.respond_to?(:enter, prvt)
    assert_equal true, @state.respond_to?(:exit,  prvt)
  end
end
