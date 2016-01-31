module StateHolderInterfaceTest
  def test_responds_to_transition_to
    assert_respond_to(@state_holder, :transition_to)
  end

  def test_responds_to_current_state
    assert_respond_to(@state_holder, :current_state)
  end

  def test_responds_to_set_new_state
    skip
    assert_respond_to(@state_holder, :set_new_state)
  end
end
