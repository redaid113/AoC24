require_relative "../utils/part"

module Day15
  class Part2 < Part
    DIRECTIONS = {
      "^" => [-1, 0],
      "v" => [1, 0],
      "<" => [0, -1],
      ">" => [0, 1]
    }

    def call
      @instructions.each do |instruction|
        if should_move_robot(instruction)
          @robot = @robot.zip(DIRECTIONS[instruction]).map(&:sum)
        end

      end

      result = 0

      @grid.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          result += i*100 + j if cell == "["
        end
      end
      puts "Result: #{result}"
    end

    def should_move_robot(instruction)
      if instruction == ">" || instruction == "<"
        return move_left_right(@robot, DIRECTIONS[instruction])
      end
      return move_up_down(@robot, DIRECTIONS[instruction])
    end

    def get_group(pos, dir)
      next_pos = pos.zip(dir).map(&:sum)

      return [pos] + get_group(next_pos, dir) + get_group([next_pos[0], next_pos[1] + 1], dir) if @grid[next_pos[0]][next_pos[1]] == "["
      return [pos] + get_group(next_pos, dir) + get_group([next_pos[0], next_pos[1] - 1], dir) if @grid[next_pos[0]][next_pos[1]] == "]"
      return [pos]
    end

    def can_move_group?(positions, dir)
      positions.all? do |pos|
        next_pos = pos.zip(dir).map(&:sum)
        next false if next_pos[0] < 0 || next_pos[0] >= @grid.length || next_pos[1] < 0 || next_pos[1] >= @grid[0].length
        next false if @grid[next_pos[0]][next_pos[1]] == "#"
        next true
      end
    end

    def move_group(pos, dir)
      next_pos = pos.zip(dir).map(&:sum)
      if @grid[next_pos[0]][next_pos[1]] == "."
        @grid[next_pos[0]][next_pos[1]] = @grid[pos[0]][pos[1]]
        @grid[pos[0]][pos[1]] = "."
        return
      end
      if @grid[next_pos[0]][next_pos[1]] == "["
        move_group(next_pos, dir)
        move_group([next_pos[0], next_pos[1] + 1], dir)
        @grid[next_pos[0]][next_pos[1]] = @grid[pos[0]][pos[1]]
        @grid[pos[0]][pos[1]] = "."
        return
      end
      if @grid[next_pos[0]][next_pos[1]] == "]"
        move_group(next_pos, dir)
        move_group([next_pos[0], next_pos[1] - 1], dir)
        @grid[next_pos[0]][next_pos[1]] = @grid[pos[0]][pos[1]]
        @grid[pos[0]][pos[1]] = "."
        return
      end
    end

    def move_up_down (pos, dir)
      positions = get_group(pos, dir)
      if can_move_group?(positions, dir)
        move_group(pos, dir)
        return true
      end
      false
    end

    def move_left_right(pos, dir)
      next_pos = pos.zip(dir).map(&:sum)
      return false if next_pos[0] < 0 || next_pos[0] >= @grid.length || next_pos[1] < 0 || next_pos[1] >= @grid[0].length
      return false if @grid[next_pos[0]][next_pos[1]] == "#"

      next_free = @grid[next_pos[0]][next_pos[1]] == "."
      is_box = @grid[next_pos[0]][next_pos[1]] == "[" || @grid[next_pos[0]][next_pos[1]] == "]"
      can_move_box = is_box && move_left_right(next_pos, dir)

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
      @grid = @paragraphs[0]
        .split("\n")
        .map{|line| line.chars()}
        .map do |row|
          line = row.map do |cell|
            next "[]" if cell == "O"
            next "##" if cell == "#"
            next ".." if cell == "."
            next "@." if cell == "@"
          end
          line.join("").chars()
        end

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
