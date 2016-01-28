class DummyState < State
  attr_reader :holder, :previous_state
  def initialize(holder, previous_state)
    @holder = holder
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
