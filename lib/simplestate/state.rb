class State
  @list = {}

  def self.list
    @list
  end


  attr_reader :holder
  def initialize(holder:, opts: {})
    @holder = holder
    State.list[self.symbol]= self
  end

  def name
    'State'
  end
  alias :to_s :name

  def symbol
    name.to_sym
  end

  private
    def transition_to(state)
      holder.transition_to(state)
    end

    def enter
      raise NotImplementedError, "#enter was called on an instance of State either directly or via super."
    end

    def exit
      raise NotImplementedError, "#exit was called on an instance of State either directly or via super."
    end
end
