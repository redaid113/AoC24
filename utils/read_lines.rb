require_relative "./callable"

class ReadLines
  extend Callable

  def initialize(input:)
    @input = input
  end

  def call
    lines = @input.split("\n")
  end
end
