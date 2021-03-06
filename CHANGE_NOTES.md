#### SimpleState version 2.0.14
Tests with Ruby 2.3.2 pass. Removed tests with rbx. Travis-ci not yet running tests for Ruby 2.4.0preview3.


#### SimpleState version 2.0.13
In State and StateHolder the opts argument to initialize now defaults to nil. Descendents may use this for their own purposes. Recommend use of a configuration object or a hash to pass values via this argument.
State no longer implements the name method. It will raise Not ImplementedError if called. State descendants must provide their own implementation.


#### SimpleState version 2.0.12
NullState now correctly inherits from State rather than mimicking State.
Code grooming.


#### SimpleState version 2.0.11
Drop travis check against ruby 2.2.
Add tests to bring up reported test coverage to 100%. Add test coverage badge to README.


#### SimpleState version 2.0.10
Add rubocop setup. Set rubocop target ruby version to 2.3. Fix an unused method argument warning about state_holder#initialize. Set up CodeClimate test coverage reporting.


#### SimpleState version 2.0.9
Make stateholder#transition_to a private method. Should have done all along. This is not representative of an event but rather a handler of the internal process of changing states.


#### SimpleState version 2.0.8
Cleanup tests. Remove some cruft.


#### SimpleState version 2.0.7
Provide initial state in the call to StateHolder#start. The call signatures for StateHolder#initialize and #start remain supported. This may change with the next major version change. Note that the state history will no longer begin with :NullState.


#### SimpleState version 2.0.6
Remove some cruft from testing setup.
Code grooming.


#### SimpleState version 2.0.5
Up date README to reflect creation of the simplestate-demo app.
Add #keys convenience method to StateList instances.


#### SimpleState version 2.0.4
Minor changes to README.
AddGemfile.lock to the git tracked documents.


#### SimpleState version 2.0.3
Move maintenance of list of states available to an instance of StateList. This instance is held by the state holder. Allows multiple state holders to each have their own list of available states. Removes the effective global state being maintained in the State class.


#### SimpleState version 2.0.0
Ruby version requirement has changed to: __>= 2.1.0__ . (Ruby 2.0.0 can be used with some minor modification: Default values must be provided for all keyword arguments.)

State:
States are represented as 'singleton' instances of their respective classes and are referenced by their symbolized names.

StateHolder:
The alternative syntax 'start\_in' to specify the initial state to the state holder is no longer supported.
The setter __#hx\_size\_limit=__ is no longer supported.
The method __#set\_current\_state__ is no longer supported. This bypassed the transition logic and could lead to an inaccurate state history.
__#start__ is provided to put the state\_holder in it's initial state. This must be called after creation of the stateholder and the associated states. The stateholder will not respond to events until this is called.

StateHistory:
This has been added to separate the responsibility for management of state history from StateHolder.


#### SimpleState version 1.0.0
A state holder tracks the history of state transitions in an array accessed via __#state_history__. The array size defaults to 5. The last item in the array will be the most recent previous state instance. The size may be set at holder creation in the opts hash (:hx\_size\_limit). The history size limit has a getter and a setter defined as well. (__#hx\_size\_limit=__  and  __#hx\_size\_limit__).

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

Please note that the State instance method, __#previous\_state\_class__, has been removed in this release.


#### SimpleState version 0.3.0
The 0.3.0 version contained a serious code smell: A state was expected to know about the history of state transitions. However, a state should know only the states to which it may transition and it's holder to support triggering those transitions. Knowlege of the transition history belongs with the state holder, if it is tracked at all.

