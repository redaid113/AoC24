require_relative "../utils/part"

module Day1
  class Part2 < Part
    def call
      count = {}
      for b in @list_b
        count[b] = count[b] || 0
        count[b] += 1
      end

      result = 0
      for a in @list_a
        result += a * (count[a] || 0)
      end

      puts "Result: #{result}"
    end

    def parse_input
      @list_a = []
      @list_b = []
      @file_lines.map do |line|
        a, b = line.split(" ").map(&:to_i)
        @list_a << a
        @list_b << b
      end
    end
  end
end
