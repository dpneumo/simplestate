module Button
  class On < State
    def press
      transition_to(Off)
      holder.messages << "#{holder.name} is off"
    end

    def name
      'On'
    end

  private
    def enter
      holder.messages << "Entered the On state"
    end

    def exit
      holder.messages << "Exited the On state"
    end
  end

  class Off < State
    def press
      transition_to(On)
      holder.messages << "#{holder.name} is on"
    end

    def name
      'Off'
    end

  private
    def enter
      holder.messages << "Entered the Off state"
    end

    def exit
      holder.messages << "Exited the Off state"
    end
  end

  class Button < StateHolder
    attr_reader :color
    def initialize(opts={})
      @color = opts.fetch :color
      super
    end

    def name
      "Button"
    end

    def messages
      @messages ||= []
    end

    def prior_state
      state_history.last.class
    end
  end
end
