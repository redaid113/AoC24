require_relative "../utils/part"
require "set"

module Day20
  class Part2 < Part
    DIRECTIONS = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    CHEAT_TIME = 20

    def call
      result = cheats.count{|cheat| cheat >= 100}
      puts "Result: #{result}"
    end

    def cheats
      distance_from_start = bfs(@start)
      distance_from_end = bfs(@end)

      shortest_path = distance_from_end[@start]

      walkable = @grid.each_with_index.map{|row, y| row.each_with_index.map{|c, x| [y, x] if c != "#"}.compact}.flatten(1)

      cheating = []
      walkable.each do |(y, x)|
        for dy in -CHEAT_TIME..CHEAT_TIME do
          ry = CHEAT_TIME - dy.abs
          for dx in -ry..ry do
            candidate = [y + dy, x + dx]
            next unless distance_from_start.key?(candidate)

            shortcut = distance_from_start[[y, x]] + distance_from_end[candidate] + dy.abs + dx.abs
            cheating << shortest_path - shortcut if shortcut < shortest_path
          end
        end
      end
      cheating
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

        DIRECTIONS
          .map { |dy, dx| [y + dy, x + dx] }
          .select { |ny, nx| in_bounds?(ny, nx) }
          .select { |ny, nx| @grid[ny][nx] != "#" }
          .select { |ny, nx| !visited.include?([ny, nx]) }
          .each do |ny, nx|
            queue.push([ny, nx, d+1])
          end
      end
      shortest_path
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
