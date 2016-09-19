require_relative 'button_requires.rb'

# States
class On < State
  attr_reader :logger
  def initialize( holder: ,
                  opts: {} )
    @logger = opts.fetch :logger, Logger.new('logfile.log')
    super
  end

  def press
    transition_to(:Off)
  end

  def name
    'On'
  end

  def color
    'Green'
  end

  private
  def enter
    flash(3)
    logger.info "Entered the #{name} state."
  end

  def exit
    logger.info "Exited the #{name} state."
  end

  def flash(n)
    # n.times { turn_button_light_off_then_on }
  end
end


class Off < State
  attr_reader :logger
  def initialize( holder: ,
                  opts: {} )
    @logger = opts.fetch :logger, Logger.new('logfile.log')
    super
  end

  def press
    transition_to(:On)
  end

  def name
    'Off'
  end

  def color
    'Red'
  end

  private
  def enter
    buzz(1)
    logger.info "Entered the #{name} state."
  end

  def exit
    logger.info "Exited the #{name} state."
  end

  def buzz(sec=0.5)
    # sound buzzer for sec seconds
  end
end


# State Holder
class Button < StateHolder
  attr_reader :name, :type
  def initialize( opts: {} )
    @name = opts.fetch :name
    @type = opts.fetch :type, 'Very Small'
    super
  end

  def prior_state
    history[-2] || :NullState
  end
end

class MyLogger
  def info(txt)
    puts txt
  end
end

class Runner
  attr_reader :launch_button
  def initialize
    @launch_button = Button.new( opts: {name: 'Launch', type: 'Large'} )
    On.new( holder: @launch_button, opts: {logger: MyLogger.new} )
    Off.new( holder: @launch_button, opts: {logger: MyLogger.new} )
  end

  def launch_sequence_begin
    launch_button.start(:Off)
  end

  def launch_is_go
    launch_button.press
  end

  def launch
    launch_button.press
  end
end

