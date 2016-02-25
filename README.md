[![Gem Version](https://badge.fury.io/rb/simplestate.svg)](https://badge.fury.io/rb/simplestate) [![Build Status](https://travis-ci.org/dpneumo/simplestate.svg?branch=master)](https://travis-ci.org/dpneumo/simplestate)
[![Code Climate](https://codeclimate.com/github/dpneumo/simplestate/badges/gpa.svg)](https://codeclimate.com/github/dpneumo/simplestate)

# Simplestate
````ruby
class Button < StateHolder
  def initialize(opts={})
    super
  end
end

class Off < State
  def press; transition_to(On); end
  private
    def enter
      # send_message_to_log("entering off state")
      # turn_light_off
    end

    def exit
      # send_message_to_log("leaving off state")
    end
end

class On < State
  def press; transition_to(Off); end
  private
    def enter
      # send_message_to_log("entering on state")
      # turn_light_on
    end

    def exit
      # send_message_to_log("leaving on state")
    end
end

button = Button.new(start_in: Off)
button.press    #=> current_state: On
button.press    #=> current_state: Off
````
# Description
Simplestate arose out of a desire for a very low ceremony mechanism to implement a state machine. SimpleDelegator (delegate.rb) is used to implement this. Because SimpleDelegator supports dynamically swapping the object to which methods are delegated, it provides a good base for Simplestate.

The StateHolder class provides the required functionality for a basic state machine: methods to set the initial state and to transition to a new state. To complement this a State class is provided to serve as ancestor to the states of the state machine. A State instance stores a reference to the state holder and a __#transition_to__ method which simply calls the state holder's __#transition_to__.

StateHolder and State are not expected to be used directly. Rather, they are intended to be inherited from. The child state holder should provide methods not specific to its current state. A child state should provide methods specific to that state. The public methods of a child state act as receivers of event messages via delegation from the state holder. Such events may cause effects that are managed by the current state and may also cause transition to a new state. State change logic is expected to be held within the current state. Two private methods, __#enter__ and __#exit__, *must* be provided by each state. These are called by the state holder __#transition_to__ method at the appropriate points in the state life cycle. Neither __#enter__ nor __#exit__ nor any other private method of a state are intended to be called by a user of the state holder.

For convenience StateHolder provides instance methods, __#current_state__ and __#set_new_state__, to provide easy access to the underlying methods, __\_\_getobj\_\___ and __\_\_setobj\_\___, of SimpleDelegator. A method to retrieve the history of state transitions from the state holder, __#state_history__, is also provided. Since the transition history could grow quite large that history is limited to the last 5 transitions by default. The history size limit may be changed via __#hx_size_limit__. That limit may be changed at any time. Changes to the limit will take effect at the next state transition.

Simplestate does not provide a DSL for specifying the events, states and allowed state transitions. That logic must be specified within each state. Neither does Simplestate provide any mechanism for serialization. There is no "magic" here. It is just a couple of PORO's. As such, it is very easy to see and to reason about what is happening within Simplestate. It should not be too difficult to add serialization support to Simplestate.

As an aside, I have looked into providing the Simplestate functionality via a module. However, I found that the SimpleDelegator class provides delegation via a mechanism that makes a module based Simplestate implementation very difficult to achieve. The complexity of that implementation seemed to be not worth the effort. I think the [StatePattern](https://github.com/dcadenas/state_pattern) gem by Daniel Cadenas, the inspiration for Simplestate, ran into just this problem. I chose to avoid that issue by relying solely on inheritance.


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

#### State Holder
Inherit from StateHolder to create the class of the object that will hold states. You *must* call super if you provide an initialize method in your holder class:

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

Creation of a StateHolder instance *must* specify the initial state class. StateHolder expects to receive the initial state class in an opts hash at creation:

```ruby
button = Button.new(initial_state_class: Off)
```
or use this alternate syntax:

```ruby
button = Button.new(start_in: Off)
```
If you want to set additional attributes at creation of a new button, do so within the opts hash when new is called. Set the attribute from the opts hash in initialize.

```ruby
button = Button.new(start_in: Off, color: 'Red')
```

#### States

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
The subclassed state must provide *private* __#enter__ and __#exit__ methods. Any other state methods intended to be available via a method call on the state holder must be public. __#enter__ and __#exit__ will always be called appropriately during state transitions.

A state has access to methods on the state holder via __#holder__:

```ruby
holder.a_special_holder_method
```

#### version 1.0.0
A state holder tracks the history of state transitions in an array accessed via __#state_history__. The array size defaults to 5. The last item in the array will be the most recent previous state instance. The size may be set at holder creation in the opts hash (:hx_size_limit). The history size limit has a getter and a setter defined as well. (__#hx_size_limit=__  and  __#hx_size_limit__).

```ruby
class Button < StateHolder
  ...
  def prior_state
    state_history.last.class
  end
end

 # Then in tests for example:
def setup
  @button = Button.new(start_in: Off, color: 'Red', hz_size_limit: 3)
end

def test_a_button_returns_its_last_prior_state
  @button.press # Curr state: On,  Prior state: Off
  @button.press # Curr state: Off, Prior state: On
  assert_equal On, @button.prior_state
end
```

Please note that the State instance method, __#previous_state_class__, has been removed in this release.

#### version 0.3.0
The 0.3.0 version contained a serious code smell: A state was expected to know about the history of state transitions. However, a state should know only the states to which it may transition and it's holder to support triggering those transitions. Knowlege of the transition history belongs with the state holder, if it is tracked at all.

#### usage example
The button module (test/dummys/button.rb) provides an example of the usage of Simplestate. Tests of this are provided in simplestate_test.rb.

## Alternatives

If a DSL is desired, complex state functionality is required, events may arrive asynchronously from multiple sources, or state machine functionality must be provided via inclusion of a module rather than via inheritance then Simplestate is probably not appropriate. Consider looking at the [Statemachine](https://github.com/pluginaweek/state_machine), [AASM](https://github.com/aasm/aasm) or [Workflow](https://github.com/geekq/workflow) gems. [The Ruby Toolbox](https://www.ruby-toolbox.com/categories/state_machines.html) provides links to several other statemachine implementations.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

StateHolderInterfaceTest and StateInterfaceTest are provided to verify that your state holder and state instances respond to the minimum required method calls for each. Simply include these in the tests of your decendents of StateHolder and State and in any dummies of these classes you may use in your tests.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dpneumo/simplestate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
