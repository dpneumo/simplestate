class DummyStateHolder
  # Designed to match the public interface of decendents of StateHolder

  attr_reader :initial_state_name, :state_history

  def initialize(initial_state_name: 'DummyState', state_history: StateHistory.new, opts: {})
    @initial_state_name = initial_state_name
    @state_history =      []
    @current_state = 'DummyState'
  end

  def start
  end

  def transition_to(new_state_name)
    @current_state = new_state_name
  end

  def current_state
    @current_state
  end

  def history
    []
  end

  def hx_size_limit
    1
  end
end
