require_relative "../utils/part"
require "set"

module Day18
  class Part1 < Part
    MAX_GRID_VALUE = 70
    DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    def call
      falling_bytes(1024)
      result = dfs()
      puts "Result: #{result}"
    end

    def dfs
      queue = Queue.new([[[0, 0], 0]])
      visited = Set.new()
      while (!queue.empty?()) do
        current, distance = queue.pop()
        return distance if current == [MAX_GRID_VALUE, MAX_GRID_VALUE]
        next if visited.include?(current)
        visited.add(current)

        x, y = current

        DIRECTIONS.each do |(dx, dy)|
          new_x, new_y = x + dx, y + dy
          next if !in_bounds?(new_x, new_y)
          next if @grid[new_y][new_x] || visited.include?([new_x, new_y])

          queue << [[new_x, new_y], distance+1]
        end
      end
      0
    end

    def in_bounds?(x, y)
      x >= 0 && x <= MAX_GRID_VALUE && y >= 0 && y <= MAX_GRID_VALUE
    end

    def falling_bytes(count)
      for i in 0...count
        x, y = @bytes[i]
        @grid[y][x] = true
      end
    end

    def parse_input
      @bytes = @file_lines.map { |line| line.split(",").map(&:to_i) }
      @grid = Array.new(MAX_GRID_VALUE+1) { Array.new(MAX_GRID_VALUE+1, false) }
    end
  end
end
