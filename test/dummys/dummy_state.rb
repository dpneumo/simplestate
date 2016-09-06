class DummyState
  # Designed to match the public interface of decendents of State

  def self.list
    {}
  end


  attr_reader :holder
  def initialize(holder:, opts: {})
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
