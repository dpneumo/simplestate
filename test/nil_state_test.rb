require 'test_helper'
require 'state_interface_test'

class NilStateTest < Minitest::Test
  def setup
    @state = NilState.new(nil, nil)
  end

  include StateInterfaceTest
end
