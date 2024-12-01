require_relative "../utils/part"

module Day1
  class Part1 < Part
    def call
      @list_a.sort!
      @list_b.sort!

      diff = 0
      for i in 0..@list_a.length-1
        diff += (@list_a[i] - @list_b[i]).abs
      end

      puts "Result: #{diff}"
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
