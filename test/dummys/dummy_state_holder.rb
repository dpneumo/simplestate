class DummyStateHolder
  def initialize(opts={})
  end

  def transition_to(new_state_class)
    set_new_state(new_state_class)
  end

  def set_new_state(new_state_class)
    @cs = new_state_class
  end

  def current_state
    @cs
  end

private
  def current_state=(state)
    @cs = state
  end
end
