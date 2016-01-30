class StateHolder < SimpleDelegator
  def initialize(opts={})
    set_initial_state_from(opts)
    # Set current_state to initial state within SimpleDelegator
    super(@initial_state)
  end

  def transition_to(new_state_class)
    current_state.send(:exit)
    set_new_state(new_state_class)
    current_state.send(:enter)
  end

  def set_new_state(new_state_class)
    new_state = new_state_class.new(self, current_state.class)
    self.current_state = new_state
  end

  def current_state
    __getobj__
  end

private
  def current_state=(state)
    __setobj__(state)
  end

  def set_initial_state_from(opts)
    initial_state_class = opts.fetch :start_in,
                         (opts.fetch :initial_state_class, nil)
    @initial_state = initial_state_class.new(self, nil)
  end

end
