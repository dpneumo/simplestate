class NullState < State
  # Simplifies call via super to SimpleDelegator during StateHolder#new
  def self.list
    {}
  end

  def name
    'NullState'
  end

private
  def enter
  end

  def exit
  end
end
