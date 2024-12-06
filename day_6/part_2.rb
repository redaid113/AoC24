require_relative "../utils/grid"
require_relative "../utils/part"
require 'set'

module Day6
  class AMazingRace
    DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

    def initialize(grid, guard)
      @grid = Marshal.load(Marshal.dump(grid))
      @guard = Marshal.load(Marshal.dump(guard))
    end

    def mouse_trap?
      found = Set.new
      while !outside?(@guard[:r], @guard[:c]) do
        break if found.include?("#{@guard[:r]}-#{@guard[:c]}-#{@guard[:d]}")
        found.add("#{@guard[:r]}-#{@guard[:c]}-#{@guard[:d]}")
        move_guard
      end

      return found.include?("#{@guard[:r]}-#{@guard[:c]}-#{@guard[:d]}")
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
  end

  class Part2 < Part
    DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

    def call
      result = 0
      for r in 0..@grid.max_row do
        for c in 0..@grid.max_col do
          if @grid.get(r, c) == "."
            @grid.set(r, c, "#")
            result += 1 if AMazingRace.new(@grid, @guard).mouse_trap?
            @grid.set(r, c, ".")
          end
        end
      end
      puts "Result: #{result}"
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
