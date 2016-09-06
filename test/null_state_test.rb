require 'test_helper'
require 'interface/state_interface_test'

class NullStateTest < Minitest::Test
  def setup
    @state = NullState.new
  end

  include StateInterfaceTest

  def test_NullState_is_added_to_State_list_of_created_states
    assert State.list.key?(:NullState)
  end
end
