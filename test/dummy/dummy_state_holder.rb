# Designed to match the public interface of decendents of StateHolder
class DummyStateHolder
  attr_reader :initial_state

  def initialize( initial_state: nil,
                  state_history: [],
                  state_list: {},
                  opts: nil )
    @initial_state = initial_state
    @state_history = state_history
    @state_list    = state_list
    @opts = opts
    @current_state = 'DummyState'
  end

  def start(init_state=initial_state)
  end

  def transition_to(state)
    @current_state = state
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

  private
  def add_state(state_instance)
  end
end
