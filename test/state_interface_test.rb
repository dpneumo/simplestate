module StateInterfaceTest
  def test_responds_to_holder
    assert_respond_to(@state, :holder)
  end

  def test_responds_to_pvt_methods_enter_exit_and_transition_to
    prvt = true
    assert_equal true, @state.respond_to?(:enter, prvt)
    assert_equal true, @state.respond_to?(:exit,  prvt)
    assert_equal true, @state.respond_to?(:transition_to, prvt)
  end
end
