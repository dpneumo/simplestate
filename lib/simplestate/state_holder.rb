require_relative '../simplestate/state_history'
require_relative 'null_state'

class StateHolder < SimpleDelegator
  attr_reader :initial_state_name, :state_history

  def initialize(initial_state_name:, state_history: StateHistory.new, opts: {})
    @initial_state_name = initial_state_name
    @state_history = state_history

    super(NullState.new)
  end

  def start
    state_history << current_state.name
    self.current_state = State.list[initial_state_name]
  end

  def transition_to(new_state_name)
    leave_old_state
    enter_new_state(new_state_name)
  end

  def current_state
    __getobj__
  end

private
  def leave_old_state
    state_history << current_state.name
    current_state.__send__(:exit)
  end

  def enter_new_state(new_state_name)
    self.current_state = State.list[new_state_name]
    current_state.__send__(:enter)
  end

  def current_state=(state)
    __setobj__(state)
  end
end
