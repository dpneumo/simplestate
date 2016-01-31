class NilState
  attr_reader :holder, :previous_state_class, :previous_states
  def initialize(holder, previous_state_class)
    @holder = holder
    @previous_state_class = previous_state_class
    @previous_states = []
  end

private
  def transition_to(new_state_class)
  end

  def enter
  end

  def exit
  end
end
