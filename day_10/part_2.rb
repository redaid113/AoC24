require_relative "../utils/part"

module Day10
  class Part2 < Part
    DIRECTIONS = [[-1, 0], [1, 0], [0, -1], [0, 1]]

    def call
      scores = @grid.map { |row| [] * row.length }
      zeros = get_zeros

      for r in 0..@grid.length-1 do
        for c in 0..@grid[r].length-1 do
          next if scores[r][c] != nil
          walkies(r, c, scores)
        end
      end

      result = zeros.sum{|r, c| scores[r][c].length}
      puts "Result: #{result}"
    end

    def walkies(r, c, scores)
      return scores[r][c] if scores[r][c] != nil
      if @grid[r][c] == 9
        scores[r][c] = [[r, c]]
        return [[r, c]]
      end

      scores[r][c] = DIRECTIONS
        .select{|dr, dc| in_bounds?(r+dr, c+dc)}
        .select{|dr, dc| @grid[r+dr][c+dc] == @grid[r][c] + 1}
        .map{|dr, dc| walkies(r+dr, c+dc, scores) }
        .reduce([], :+)

      scores[r][c]
    end

    def in_bounds?(r, c)
      r.between?(0, @grid.length-1) && c.between?(0, @grid[r].length-1)
    end

    def get_zeros
      zeros = []
      for r in 0..@grid.length-1 do
        for c in 0..@grid[r].length-1 do
          zeros << [r, c] if @grid[r][c] == 0
        end
      end

      zeros
    end

    def parse_input
      @grid = @file_lines.map { |line| line.split("").map{|c| c == "." ? -1 : c}.map(&:to_i) }
    end
  end
end
