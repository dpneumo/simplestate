class State
  @@dict = {}

  attr_reader :holder
  def initialize(holder: nil, opts: {})
    @holder = holder

    @@dict[self.name]= self
  end

  def self.list
    @@dict
  end

  def name
    'State'
  end
  alias :to_s :name

  private
    def transition_to(new_state_name)
      holder.transition_to(new_state_name)
    end

    def enter
      raise NotImplementedError, "#enter was called on an instance of State either directly or via super."
    end

    def exit
      raise NotImplementedError, "#exit was called on an instance of State either directly or via super."
    end
end
