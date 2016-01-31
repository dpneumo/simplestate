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
    raise "#{self.class.name} does not implement #enter."
  end

  def exit
    raise "#{self.class.name} does not implement #exit."
  end
end
