require 'test_helper'
require 'interface/state_holder_interface_test'
require 'dummy/dummy_state_holder'

class DummyStateHolderTest < Minitest::Test
  def setup
    @state_holder = DummyStateHolder.new
  end

  include StateHolderInterfaceTest
end
