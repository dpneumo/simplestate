# Simplestate

Simplestate arose out of a need to build a simple statemachine. This implementation was inspired by Daniel Cadenas' StatePattern gem. (https://github.com/dcadenas/state_pattern)

I have chosen to eschew serialization of state for now. SimpleDelegator provides the basic functionality required for this implementation. SimpleDelegator supports dynamically swapping the object to which delegated calls are made.

The StateHolder class derives from SimpleDelegator. A 'real' state holding object inherits from StateHolder. StateHolder provides support for transitioning between states. Any method not available on the state holder will be forwarded to the currently held state.

The State class from which all 'real' states inherit has private #enter and #exit methods that raise an exception. Real states are expected to override these methods with at least 'no-ops'. Any public methods added to a 'real' state can be called on the object holding the state via inherited SimpleDelegator. #enter and #exit like all private state methods are not reachable via the SimpleDelagator functionality. They are intended for internal use by the state instance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simplestate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simplestate

## Usage
Inherit from StateHolder to create the class of the object that will hold states:

```ruby
class Button < StateHolder
  attr_reader :color
  def initialize(opts={})
    @color = opts.fetch :color
    super
  end

  # button methods here
end
```

StateHolder expects to receive the initial state class in an opts hash at creation. Creation of a holder instance *must* specify the initial state class:

```ruby
button = Button.new(initial_state_class: Off)
```
or use this alternate syntax:

```ruby
button = Button.new(start_in: Off)
```
If you want to set additional attributes at creation of a new button, do so within the opts hash when new is called. Set the attribute from the opts hash in initialize. You *must* call super if you provide an initialize method in your holder class.

```ruby
button = Button.new(start_in: Off, color: 'Red')
```


Inherit from State to create a class to provide specific state behaviors:

```ruby
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
```
The subclassed state may provide *private* enter and exit methods. Any other state methods intended to be available via a method call on the state holder must be public. #enter and #exit will always be called appropriately during state transitions.

A state has access to methods on the state holder via #holder:

```ruby
holder.a_special_holder_method
```

# version 0.3.0 addition
A state has a *previous_states* method that returns an array of the states through which the state holder has transitioned to reach that state. Currently that array size is limited to 1. Old entries are dropped as new entries are added. DO NOT rely on that size limit. The last item in the list will be the most recent previous state. This is a public method on a state so it can be used via the state holder:

```ruby
class Button < StateHolder
  ...

  def prior_state
    previous_states.last.class
  end
end

 # Then in tests for example:
def test_a_button_returns_its_last_prior_state
  @button.press # Curr state: On,  Prior state: Off
  @button.press # Curr state: Off, Prior state: On
  assert_equal On, @button.prior_state
end
```

Please note that State#previous_state_class does not have to agree with previous_states.last.class. #previous_state_class is set arbitrarily at instance creation. #previous_states is updated automatically at each state transition. #previous_state_class will be removed at some point in the future.

# usage example
The button module provides an example of the usage of Simplestate. Tests of this are provided in simplestate_test.rb.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dpneumo/simplestate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

