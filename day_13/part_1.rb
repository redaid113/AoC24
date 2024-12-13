require_relative "../utils/part"

module Day13
  class Part1 < Part
    def call
      result = @games.sum{ |game| cost_to_win(game) }
      puts "Result: #{result}"
    end

    def cost_to_win(game)
      x, y = winning_moves(game)
      return (x * 3 + y).to_i if x == x.to_i && y == y.to_i && x >= 0 && y >= 0
      0
    end

    def winning_moves(game)
      a, b, t = game

      y = (a[0]*t[1] - a[1]*t[0]) / (a[0]*b[1] - a[1]*b[0]).to_f
      x = (t[0] - b[0] * y) / a[0].to_f
      [x, y]
    end


    def parse_line(line)
      line.scan(/\d+/).map(&:to_i)
    end

    def parse_input
      @games = @paragraphs.map{ |paragraph| paragraph.split("\n").map{|line| parse_line(line)} }
    end

  end
end
