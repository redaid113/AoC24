require_relative "../utils/part"
require "set"

module Day18
  class Part2 < Part
    MAX_GRID_VALUE = 70
    BYTE_FALL_COUNT = 1024
    DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]]

    def call
      byte_copy = @bytes.dup
      falling_bytes(BYTE_FALL_COUNT)
      for byte_index in (BYTE_FALL_COUNT+1)..byte_copy.length
        falling_bytes(1)
        break if dfs() == 0
      end
      puts "Result: #{byte_copy[byte_index-1].join(",")}"
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
      (1..count).each do
        x, y = @bytes.shift()
        @grid[y][x] = true
      end
    end

    def parse_input
      @bytes = @file_lines.map { |line| line.split(",").map(&:to_i) }
      @grid = Array.new(MAX_GRID_VALUE+1) { Array.new(MAX_GRID_VALUE+1, false) }
    end
  end
end
