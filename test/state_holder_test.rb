require 'test_helper'
require 'state_holder_interface_test'

class StateHolderTest < Minitest::Test
  def setup
    @state_holder = StateHolder.new(initial_state_class: State)
  end

  include StateHolderInterfaceTest
end
