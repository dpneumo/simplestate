require 'dummys/dummy_state_holder'

# Designed to match the public interface of decendents of State
class DummyState
  attr_reader :holder
  def initialize(holder: DummyStateHolder.new, opts: {})
    @holder = holder
  end

  def name
    'DummyState'
  end
  alias :to_s :name

  def symbol
    :DummyState
  end


private
  def transition_to(state)
    holder.transition_to(state)
  end

  def enter
  end

  def exit
  end
end
