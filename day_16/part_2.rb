require_relative "../utils/part"
require 'fc'
require 'set'

module Day16
  class Part2 < Part
    NORTH = [-1, 0]
    EAST = [0, 1]
    SOUTH = [1, 0]
    WEST = [0, -1]
    DIRECTIONS = [NORTH, EAST, SOUTH, WEST]

    def call
      result = djikstra
      puts "Result: #{result}"
    end

    def djikstra
      queue = FastContainers::PriorityQueue.new(:min)
      visited = Set.new
      path_list = {}
      path_list[[@start, DIRECTIONS.index(EAST), 0.0]] = [@start]

      queue.push([@start, DIRECTIONS.index(EAST)], 0)

      while queue.size > 0 do
        p = queue.top_key
        cur, dir = queue.pop

        if cur == @end
          return path_list[[cur, dir, p]].uniq.length
        end

        next if visited.include?([cur, dir])
        visited.add([cur, dir])

        path = path_list[[cur, dir, p]]
        clockwise_turn = (dir + 5) % 4
        counter_clockwise_turn = (dir + 3) % 4
        step_forward = cur.zip(DIRECTIONS[dir]).map(&:sum)

        queue.push([cur, clockwise_turn, p + 1000], p + 1000)
        path_list[[cur, clockwise_turn, p + 1000]] ||= []
        path_list[[cur, clockwise_turn, p + 1000]] += path + [cur]

        queue.push([cur, counter_clockwise_turn, p + 1000], p + 1000)
        path_list[[cur, counter_clockwise_turn, p+1000]] ||= []
        path_list[[cur, counter_clockwise_turn, p+1000]] += path + [cur]

        queue.push([step_forward, dir], p+1) if in_bounds?(step_forward) && @grid[step_forward[0]][step_forward[1]] != "#"
        path_list[[step_forward, dir, p+1]] ||= []
        path_list[[step_forward, dir, p+1]] += path + [step_forward]
      end
      0
    end

    def in_bounds?((r, c))
      r >= 0 && r < @grid.length && c >= 0 && c < @grid[0].length
    end

    def parse_input
      @grid = @file_lines.map{ |line| line.chars }
      @start = []
      @end = []
      @grid.each_with_index do |row, r|
        row.each_with_index do |cell, c|
          @start = [r, c] if cell == "S"
          @end = [r, c] if cell == "E"
        end
      end
    end
  end
end
