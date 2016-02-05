class StateHolder < SimpleDelegator
  attr_reader :beginning, :state_history
  attr_accessor :hx_size_limit
  def initialize(opts={})
    @beginning = initial_state_class(opts)
    @hx_size_limit = opts.fetch :hx_size_limit, 5
    @state_history = []
    super(NilState.new(nil))
    transition_to beginning
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
    self.current_state = new_state_class.new(self)
  end

private
  def current_state=(state)
    __setobj__(state)
  end

  def update_state_history
    @state_history << current_state
    @state_history = @state_history.last(hx_size_limit)
  end

  def initial_state_class(opts)
    isc = opts.fetch :start_in,
                     (opts.fetch :initial_state_class, nil)
    isc ? isc : raise(NoMethodError)
  end
end
