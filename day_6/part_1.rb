require_relative "../utils/part"
require_relative "../utils/grid"
require 'set'

module Day6
  class Part1 < Part
    DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

    def call
      found = Set.new
      while !outside?(@guard[:r], @guard[:c]) do
        found.add("#{@guard[:r]}-#{@guard[:c]}")
        move_guard
      end
      puts "Result: #{found.size}"
    end

    def move_guard
      direction = DIRECTIONS[@guard[:d]]
      r = @guard[:r] + direction[0]
      c = @guard[:c] + direction[1]

      if @grid.get(r, c) == "#"
        @guard[:d] = (@guard[:d] + 1) % 4
      else
        @guard[:r] = r
        @guard[:c] = c
      end
    end

    def outside?(r, c)
      return r < 0 || r > @grid.max_row || c < 0 || c > @grid.max_col
    end

    def parse_input
      @grid = Grid.new(file_lines: @file_lines, default: ".")
      @guard = {}
      for r in 0..@grid.max_row do
        for c in 0..@grid.max_col do
          if @grid.get(r, c) == "^"
            @guard = { r: r, c: c, d: 0}
          end
        end
      end
    end
  end
end
