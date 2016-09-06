require_relative 'state'

class NullState < State
  # Simplifies call via super to SimpleDelegator during StateHolder#new
  def self.list
    {}
  end

  def name
    'NullState'
  end
  alias :to_s :name

private
  def enter
  end

  def exit
  end
end
