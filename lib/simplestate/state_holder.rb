class StateHolder < SimpleDelegator
  attr_reader :state_history
  attr_accessor :hx_size_limit
  def initialize(opts={})
    @state_history = []
    @hx_size_limit = opts.fetch :hx_size_limit, 5
    # Set current_state to nil state within SimpleDelegator
    nil_state = NilState.new(nil)
    super(nil_state)
    # Then transition to the initial state class
    initial_state_class = opts.fetch :start_in,
                         (opts.fetch :initial_state_class, nil)
    transition_to initial_state_class
  end

  def transition_to(new_state_class)
    update_state_history
    current_state.send(:exit)
    set_new_state(new_state_class)
    current_state.send(:enter)
  end

  def current_state
    __getobj__
  end

  def set_new_state(new_state_class)
    new_state = new_state_class.new(self)
    self.current_state = new_state
  end

private
  def current_state=(state)
    __setobj__(state)
  end

  def update_state_history
    @state_history << current_state
    @state_history = @state_history.last(hx_size_limit)
  end
end
