require_relative "../utils/grid"
require_relative "../utils/part"

module Day4
  class Part1 < Part
    def call
      grid = Grid.new(file_lines: @file_lines, default: ".")

      result = 0
      for r in grid.min_row..grid.max_row do
        for c in grid.min_col..grid.max_col do
          horizontal = "#{grid.get(r, c)}#{grid.get(r, c+1)}#{grid.get(r, c+2)}#{grid.get(r, c+3)}"
          result += 1 if horizontal == "XMAS" || horizontal.reverse == "XMAS"

          vertical = "#{grid.get(r, c)}#{grid.get(r+1, c)}#{grid.get(r+2, c)}#{grid.get(r+3, c)}"
          result += 1 if vertical == "XMAS" || vertical.reverse == "XMAS"

          diagonal = "#{grid.get(r, c)}#{grid.get(r+1, c+1)}#{grid.get(r+2, c+2)}#{grid.get(r+3, c+3)}"
          result += 1 if diagonal == "XMAS" || diagonal.reverse == "XMAS"

          reverse_diagonal = "#{grid.get(r, c)}#{grid.get(r+1, c-1)}#{grid.get(r+2, c-2)}#{grid.get(r+3, c-3)}"
          result += 1 if reverse_diagonal == "XMAS" || reverse_diagonal.reverse == "XMAS"
        end
      end

      puts "Result: #{result}"
    end
  end
end
