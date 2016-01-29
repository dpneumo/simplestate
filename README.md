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

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simplestate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

