module StateHolderInterfaceTest
  def test_responds_to_transition_to
    assert_respond_to(@state_holder, :transition_to)
  end

  def test_responds_to_current_state
    assert_respond_to(@state_holder, :current_state)
  end

  def test_responds_to_set_new_state
    assert_respond_to(@state_holder, :set_new_state)
  end

  def test_responds_to_state_history
    assert_respond_to(@state_holder, :state_history)
  end

  def test_responds_to_beginning
    assert_respond_to(@state_holder, :beginning)
  end

  def test_responds_to_hx_size_limit
    assert_respond_to(@state_holder, :hx_size_limit)
  end

  def test_responds_to_hx_size_limit=
    assert_respond_to(@state_holder, :hx_size_limit=)
  end
end
