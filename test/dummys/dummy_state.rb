class DummyState
  # Designed to match the public interface of decendents of State

  attr_reader :holder
  def initialize(holder:, opts: {})
    @holder = holder
  end

  def self.list
    {}
  end

  def name
    'DummyState'
  end
  alias :to_s :name

  def symbol
    :DummyState
  end


private
  def transition_to(new_state_class)
    holder.transition_to(new_state_class)
  end

  def enter
  end

  def exit
  end
end
