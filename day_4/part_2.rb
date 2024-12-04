require_relative "../utils/part"

module Day4
  class Part2 < Part
    def call
      grid = Grid.new(file_lines: @file_lines, default: ".")


      result = 0
      for r in grid.min_row..grid.max_row do
        for c in grid.min_col..grid.max_col do
          diagonal = "#{grid.get(r, c)}#{grid.get(r+1, c+1)}#{grid.get(r+2, c+2)}"
          reverse_diagonal = "#{grid.get(r+2, c)}#{grid.get(r+1, c+1)}#{grid.get(r, c+2)}"
          result += 1 if (diagonal == "MAS" || diagonal.reverse == "MAS") && (reverse_diagonal == "MAS" || reverse_diagonal.reverse == "MAS")
        end
      end

      puts "Result: #{result}"
    end

  end
end
