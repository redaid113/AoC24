require_relative "../utils/part"

module Day11
  class Part1 < Part
    def call
      for i in 0..24 do
        @stones = @stones.map do |stone|
          step(stone)
        end.flatten
      end
      puts "Result: #{@stones.length}"
    end

    def step(stone)
      return [1] if stone == 0
      str = stone.to_s
      if str.length % 2 == 0
        return [str[0..(str.length/2 - 1)].to_i, str[(str.length/2)..-1].to_i]
      end
      return [stone * 2024]
    end

    def parse_input
      @stones = @file_lines.first.split(" ").map(&:to_i)
    end
  end
end
