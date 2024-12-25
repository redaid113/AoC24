require_relative "../utils/part"

module Day25
  class Part1 < Part
    def call
      result = @keys.sum{|key| @locks.count{|lock| (0..4).all? {|i| key[i] + lock[i] <= 5}}}

      puts "Result: #{result}"
    end

    def parse_input
      @keys = []
      @locks = []
      @paragraphs.each do |paragraph|
        grid = paragraph.split("\n").map(&:chars)
        is_key = grid.last.all?{|c| c == '#'}
        values = grid.transpose.map{|row| row.count('#')-1}
        @keys << values if is_key
        @locks << values if !is_key
      end
    end
  end
end
