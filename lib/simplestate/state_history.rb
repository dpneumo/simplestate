class StateHistory
  attr_reader :list, :hx_size_limit

  def initialize(hx_size_limit: 10)
    @hx_size_limit = hx_size_limit
    @list = []
  end

  def <<(current_state_name)
    @list << current_state_name
    @list = @list.last(hx_size_limit)
    self
  end
end
