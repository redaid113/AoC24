require_relative "../utils/part"

module Day2
  class Part2 < Part
    def call
      result = @lines.count do |line|
        valid?(line) || (0..line.size-1).any? { |i| valid?(line_without_index(line, i)) }
      end

      puts "Result: #{result}"
    end

    def valid?(line)
      return false unless line == line.sort || line == line.sort.reverse
      return line.each_cons(2).all?{|a, b| a != b && (a - b).abs <= 3}
    end

    def line_without_index(line, index)
      line[0...index] + line[index+1..-1]
    end

    def parse_input
      @lines = @file_lines.map{ |line| line.split(" ").map(&:to_i)}
    end
  end
end
