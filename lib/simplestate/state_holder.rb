class StateHolder < SimpleDelegator
  def initialize(opts={})
    # Set current_state to nil state within SimpleDelegator
    nil_state = NilState.new(nil,nil)
    super(nil_state)
    # Then transition to the initial state class
    initial_state_class = opts.fetch :start_in,
                         (opts.fetch :initial_state_class, nil)
    transition_to initial_state_class
  end

  def transition_to(new_state_class)
    current_state.send(:exit)
    set_new_state(new_state_class)
    current_state.send(:enter)
  end

  def current_state
    __getobj__
  end

  def set_new_state(new_state_class)
    new_state = new_state_class.new(self, current_state.class)
    self.current_state = new_state
  end

private
  def current_state=(state)
    __setobj__(state)
  end
end
