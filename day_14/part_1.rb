require_relative "../utils/part"

module Day14

  class Part1 < Part
    SECONDS = 100
    GRID_SIZE = [101, 103]


    def call
      @robots.each do |robot|
       (1..SECONDS).each do
          robot[0] = (robot[0] + robot[2] + GRID_SIZE[0]) % GRID_SIZE[0]
          robot[1] = (robot[1] + robot[3] + GRID_SIZE[1]) % GRID_SIZE[1]
        end
      end

      half_x = GRID_SIZE[0]/2
      half_y = GRID_SIZE[1]/2

      top_left = @robots.count { |robot| robot[0] < half_x && robot[1] < half_y }
      top_right = @robots.count { |robot| robot[0] < half_x && robot[1] > half_y }
      bottom_left = @robots.count { |robot| robot[0] > half_x && robot[1] < half_y }
      bottom_right = @robots.count { |robot| robot[0] > half_x && robot[1] > half_y }

      result = top_left * top_right * bottom_left * bottom_right
      puts "Result: #{result}"
    end

    def parse_input
      @robots = @file_lines.map{ |line| line.scan(/-?\d+/).map(&:to_i) }
    end
  end
end
