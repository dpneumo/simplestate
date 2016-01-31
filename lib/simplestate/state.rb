class State
  attr_reader :holder, :previous_state_class, :previous_states
  def initialize(holder, previous_state_class)
    @holder = holder
    @previous_state_class = previous_state_class
    @previous_states = build_previous_states_list
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

  def build_previous_states_list
    hcs = holder.current_state
    psa = hcs.previous_states || []
    psa.shift
    psa << hcs
  end
end
