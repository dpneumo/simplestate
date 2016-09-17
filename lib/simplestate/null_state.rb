class NullState < State
  def name
    'NullState'
  end
  alias :to_s :name

  private
  def transition_to(state)
  end

  def enter
  end

  def exit
  end
end
