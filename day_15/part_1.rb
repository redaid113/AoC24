require_relative "../utils/part"

module Day15
  class Part1 < Part
    DIRECTIONS = {
      "^" => [-1, 0],
      "v" => [1, 0],
      "<" => [0, -1],
      ">" => [0, 1]
    }

    def call
      @instructions.each do |instruction|
        if move(@robot, DIRECTIONS[instruction])
          @robot = @robot.zip(DIRECTIONS[instruction]).map(&:sum)
        end
      end

      result = 0
      @grid.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          result += i*100 + j if cell == "O"
        end
      end
      puts "Result: #{result}"
    end

    def move (pos, dir)
      next_pos = pos.zip(dir).map(&:sum)
      return false if next_pos[0] < 0 || next_pos[0] >= @grid.length || next_pos[1] < 0 || next_pos[1] >= @grid[0].length
      return false if @grid[next_pos[0]][next_pos[1]] == "#"

      next_free = @grid[next_pos[0]][next_pos[1]] == "."
      can_move_box = @grid[next_pos[0]][next_pos[1]] == "O" && move(next_pos, dir)

      if next_free || can_move_box
        @grid[next_pos[0]][next_pos[1]] = @grid[pos[0]][pos[1]]
        @grid[pos[0]][pos[1]] = "."
        return true
      end

      return false
    end

    def print
      @grid.each do |row|
        puts row.join("")
      end
      puts "\n"
    end

    def parse_input
      @grid = @paragraphs[0].split("\n").map{|line| line.chars()}
      @instructions = @paragraphs[1].gsub("\n", "").strip.chars()

      @grid.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          if cell == "@"
            @robot = [i, j]
            return
          end
        end
      end
    end
  end
end
