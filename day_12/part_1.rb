require_relative "../utils/part"
require "set"

module Day12
  class Part1 < Part
    def call
      result = regions.sum {|region| area(region) * perimeter(region) }
      puts "Result: #{result}"
    end

    def perimeter(region)
      region.map{ |row, col| [[row-1, col], [row+1, col], [row, col-1], [row, col+1]] }
            .flatten(1)
            .select{ |row, col| !region.include?([row, col]) }
            .length
    end

    def area(region)
      region.length
    end

    def regions
      return @regions if @regions
      @regions = []
      visited = Set.new
      for r in 0..@plot.length-1
        for c in 0..@plot[r].length-1
          next if visited.include?([r, c])

          region = []
          plant = @plot[r][c]
          queue = [[r, c]]
          while !queue.empty?
            row, col = queue.shift
            next if !in_bounds?(row, col) || visited.include?([row, col]) || @plot[row][col] != plant
            visited.add([row, col])

            region << [row, col]
            queue << [row-1, col]
            queue << [row+1, col]
            queue << [row, col-1]
            queue << [row, col+1]
          end

          @regions << region
        end
      end
      @regions
    end

    def in_bounds?(row, col)
      row >= 0 && row < @plot.length && col >= 0 && col < @plot[row].length
    end


    def parse_input
      @plot = @file_lines.map{ |line| line.chars }
    end
  end
end
