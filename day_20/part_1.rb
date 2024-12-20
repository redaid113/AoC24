require_relative "../utils/part"
require "set"

module Day20
  class Part1 < Part
    DIRECTIONS = [[0, 1], [0, -1], [1, 0], [-1, 0]]

    def call

      result = cheats.count{|cheat| cheat >= 100}
      puts "Result: #{result}"
    end

    def cheats
      distance_from_start = bfs(@start)
      distance_from_end = bfs(@end)

      shortest_path = distance_from_end[@start]

      cheats = []
      for y in 0...@grid.size
        for x in 0...@grid[0].size
          next if @grid[y][x] != "#"
          possible = around(y, x)
            .select{ |ny, nx| @grid[ny][nx] != "#" }
          next if possible.size < 2

          possible
            .permutation(2)
            .map{|(ny1, nx1), (ny2, nx2)| distance_from_start[[ny1, nx1]] + distance_from_end[[ny2, nx2]] + 2}
            .select{|d| d < shortest_path}
            .each do |d|
              cheats << shortest_path - d
            end

        end
      end
      cheats
    end

    def bfs(initial)
      shortest_path = {}

      queue = [initial + [0]]
      visited = Set.new

      while !queue.empty?
        y, x, d = queue.shift

        next if visited.include?([y, x])
        visited.add([y, x])
        shortest_path[[y, x]] = d

        around(y, x)
          .select { |ny, nx| @grid[ny][nx] != "#" }
          .select { |ny, nx| !visited.include?([ny, nx]) }
          .each do |ny, nx|
            queue.push([ny, nx, d+1])
          end
      end
      shortest_path
    end

    def around(y, x)
      DIRECTIONS
        .map { |dy, dx| [y + dy, x + dx] }
        .select { |ny, nx| in_bounds?(ny, nx) }
    end

    def in_bounds?(y, x)
      y >= 0 && y < @grid.size && x >= 0 && x < @grid[0].size
    end

    def parse_input
      @grid = @file_lines.map(&:chars)
      @grid.each_with_index { |row, y| row.each_with_index{|c, x| @start = [y, x] if c == "S"} }
      @grid.each_with_index { |row, y| row.each_with_index{|c, x| @end = [y, x] if c == "E"} }
    end
  end
end
