class StateHolder < SimpleDelegator
  def initialize(opts={})
    initial_state_class = opts.fetch :initial_state_class, nil
    super(initial_state_class.new(self, nil))
  end

  def transition_to(new_state_class)
    current_state.send(:exit) if current_state
    set_new_state(new_state_class)
  end

  def set_new_state(new_state_class)
    current_state = new_state_class.new(self, current_state)
  end

  private
  def current_state=(state)
    __setobj__(state)
  end

  def current_state
    __getobj__
  end
end
