class State
  attr_reader :holder, :previous_state_class
  def initialize(holder, previous_state_class)
    @holder = holder
    @previous_state_class = previous_state_class
    @previous_states = []
  end

  def previous_states
    @previous_states
  end

  def push_previous_state(state)
    state.previous_states.shift if state
    @previous_states.push(state)
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
