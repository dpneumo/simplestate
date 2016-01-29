class State
  attr_reader :holder, :previous_state_class
  def initialize(holder, previous_state_class)
    @holder = holder
    @previous_state_class = previous_state_class
  end

private
  def transition_to(new_state_class)
    holder.transition_to(new_state_class)
  end

  def enter
    raise "#{self.class.name} does not implement #enter."
  end

  def exit
    raise "#{self.class.name} does not implement #exit."
  end
end
