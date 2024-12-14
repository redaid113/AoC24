require_relative "../utils/part"

module Day14
  class Part2 < Part
    GRID_SIZE =  [101, 103]

    def call
      seconds = 0
      loop do
        seconds += 1
        @robots.each do |robot|
          robot[0] = (robot[0] + robot[2] + GRID_SIZE[0]) % GRID_SIZE[0]
          robot[1] = (robot[1] + robot[3] + GRID_SIZE[1]) % GRID_SIZE[1]
        end
        break if tree_like?
      end

      print

      puts "Result: #{seconds}"
    end

    def tree_like?
      @robots.sort_by!{ |robot| robot[0] }
      consecutive_matching_rows = 0
      for y in 0..GRID_SIZE[1]-1
        matching_row = @robots
          .select{ |robot| robot[1] == y }
          .each_cons(3).any? {|robot1, robot2, robot3| robot1[0] + 1 == robot2[0] && robot2[0] + 1 == robot3[0] }
        consecutive_matching_rows += 1 if matching_row
        consecutive_matching_rows = 0 unless matching_row
        return true if consecutive_matching_rows == 5
      end
      false
    end

    def print
      locations = @robots.reduce({}) do |acc, robot|
        acc[[robot[0], robot[1]]] ||= 0
        acc[[robot[0], robot[1]]] += 1
        acc
      end

      for y in 0..GRID_SIZE[1]-1
        line = ""
        for x in 0..GRID_SIZE[0]-1
          if locations[[x, y]]
            line += locations[[x, y]].to_s
          else
            line += "."
          end
        end
        puts line
      end
      puts ""
    end

    def parse_input
      @robots = @file_lines.map{ |line| line.scan(/-?\d+/).map(&:to_i) }
    end
  end
end
