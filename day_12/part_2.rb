require_relative "../utils/part"
require "set"

module Day12

  class Part2 < Part
    def call
      result = regions.sum {|region| area(region) * sides(region) }
      puts "Result: #{result}"
    end

    def sides(region)
      # puts "Region: #{@plot[region[0][0]][region[0][1]]}"
      # puts "Region: #{region}"
      # puts "Corners: #{corners(region)}"
      # puts "Corners length : #{corners(region).length}"
      # puts "Area: #{area(region)}"
      # puts corners(region).length * area(region)
      # puts "--------"
      region.sum{ |row, col| outer_corners(region, row, col) + inner_corners(region, row, col) }
    end

    def outer_corners(region, row, col)
      up = [row-1, col]
      down = [row+1, col]
      left = [row, col-1]
      right = [row, col+1]

      ct = 0
      ct += 1 if [ up, left].select{ |row, col| !region.include?([row, col]) }.length == 2
      ct += 1 if [ up, right].select{ |row, col| !region.include?([row, col]) }.length == 2
      ct += 1 if [ down, left].select{ |row, col| !region.include?([row, col]) }.length == 2
      ct += 1 if [ down, right].select{ |row, col| !region.include?([row, col]) }.length == 2
      ct
    end

    def inner_corners(region, row, col)
      up = [row-1, col]
      down = [row+1, col]
      left = [row, col-1]
      right = [row, col+1]
      top_left = [row-1, col-1]
      top_right = [row-1, col+1]
      bottom_left = [row+1, col-1]
      bottom_right = [row+1, col+1]

      ct = 0


      ct += 1 if [ up, left].select{ |row, col| region.include?([row, col]) }.length == 2 && !region.include?(top_left)
      ct += 1 if [ up, right].select{ |row, col| region.include?([row, col]) }.length == 2 && !region.include?(top_right)
      ct += 1 if [ down, left].select{ |row, col| region.include?([row, col]) }.length == 2 && !region.include?(bottom_left)
      ct += 1 if [ down, right].select{ |row, col| region.include?([row, col]) }.length == 2 && !region.include?(bottom_right)
      ct
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
