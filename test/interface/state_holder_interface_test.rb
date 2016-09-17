module StateHolderInterfaceTest
  def test_responds_to_start
    assert_respond_to(@state_holder, :start)
  end

  def test_responds_to_current_state
    assert_respond_to(@state_holder, :current_state)
  end

  def test_responds_to_history
    assert_respond_to(@state_holder, :history)
  end

  def test_responds_to_hx_size_limit
    assert_respond_to(@state_holder, :hx_size_limit)
  end

  def test_responds_to_pvt_method_transition_to
    prvt = true
    assert_equal true, @state_holder.respond_to?(:transition_to, prvt)
  end
end
