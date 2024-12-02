require_relative "../utils/part"

module Day2
  class Part1 < Part
    def call
      result = @lines.count{|line| valid?(line)}
      puts "Result: #{result}"
    end

    def valid?(line)
      return false unless line == line.sort || line == line.sort.reverse
      return line.each_cons(2).all?{|a, b| a != b && (a - b).abs <= 3}
    end

    def parse_input
      @lines = @file_lines.map{ |line| line.split(" ").map(&:to_i)}
    end
  end
end
