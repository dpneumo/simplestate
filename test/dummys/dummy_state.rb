class DummyState
  attr_reader :holder
  def initialize(holder)
    @holder = holder
  end

private
  def transition_to(new_state_class)
    holder.transition_to(new_state_class)
  end

  def enter
  end

  def exit
  end
end
