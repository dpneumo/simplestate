class State
  attr_reader :holder, :previous_state
  def initialize(holder, previous_state)
    @holder = holder
    @previous_state = previous_state
    enter
  end

private
  def transition_to(new_state_class)
    holder.transition_to(new_state_class)
  end

  def enter
    "NIH"
  end

  def exit
    "NIH"
  end
end
