class NullState
  # Simplifies call via super to SimpleDelegator during StateHolder#new
  # Avoid chicken and egg problem by mimicing rather than inheriting from State

  attr_reader :holder
  def initialize(holder: nil, opts: {})
    @holder = holder
    State.list[self.symbol]= self
  end

  def self.list
    {}
  end

  def name
    'NullState'
  end
  alias :to_s :name

  def symbol
    :NullState
  end

private
  def transition_to(state)
  end

  def enter
  end

  def exit
  end
end
