class DummyState
  attr_reader :holder, :previous_state_class, :previous_states
  def initialize(holder, previous_state_class)
    @holder = holder
    @previous_states = []
  end

private
  def transition_to(new_state_class)
    holder.transition_to(new_state_class)
  end

  def enter
    "dummy enter"
  end

  def exit
    'dummy exit'
  end
end
