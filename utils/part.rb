require_relative "./callable"
require_relative "./read_lines"


class Part
  extend Callable

  def initialize(file_path:)
    @file_path = file_path
    parse_file
    parse_input
  end

  def parse_file
    @input = File.open(@file_path).read.strip
    @paragraphs = @input.split("\n\n")
    @file_lines = ReadLines.call(input: @input)
  end

  def parse_input
  end
end
