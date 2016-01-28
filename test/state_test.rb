require 'test_helper'

class StateTest < Minitest::Test
  def setup
    @state = State.new('abc', 'def')
  end

  include StateInterfaceTest
end
