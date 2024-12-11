require_relative "../utils/part"

module Day11
  ITERATION = 75
  class Part2 < Part
    def call
      counts = @stones.tally
      @stones = @stones.uniq

      for i in 0..ITERATION-1 do
        new_counts = {}
        @stones = @stones.map do |stone|
          next_stones = step(stone)
          next_stones.each do |next_stone|
            new_counts[next_stone] ||= 0
            new_counts[next_stone] += counts[stone] ? counts[stone] : 1
          end
          next_stones
        end.flatten.uniq

        counts = new_counts
      end

      puts "Result: #{counts.sum{|k,v| v}}"
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
