class State
  attr_reader :holder
  def initialize(holder)
    @holder = holder
  end

private
  def transition_to(new_state_class)
    holder.transition_to(new_state_class)
  end

  def enter
    raise NotImplementedError, "need to define #enter."
  end

  def exit
    raise NotImplementedError, "need to define #exit."
  end
end
