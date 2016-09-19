class State
  attr_reader :holder
  def initialize( holder: ,
                  opts: nil )
    @holder = holder
    @holder.__send__(:add_state, self)
    @opts = opts
    # opts is provided to allow super to be used 'bare' in the argument list of descendents.
    # It will be silently ignored here. In the descendent opts may be anything,
    # but a configuration object or a hash paired with appropriate accessors is recommended.
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
    holder.__send__ :transition_to, state
  end

  def enter
    raise NotImplementedError, "#enter was called on an instance of State either directly or via super."
  end

  def exit
    raise NotImplementedError, "#exit was called on an instance of State either directly or via super."
  end
end
