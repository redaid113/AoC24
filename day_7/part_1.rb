require_relative "../utils/part"

module Day7
  class Part1 < Part
    def call
      result = @lines.select{|line| valid?(line)}.sum{|line| line[0]}
      puts "Result: #{result}"
    end

    def valid?(line)
      sum, first, *numbers = line
      [:+, :*].repeated_permutation(numbers.size).any? do |ops|
          score = first
          numbers.each_with_index do |n, i|
            score += n if ops[i] == :+
            score *= n if ops[i] == :*
          end
          score == sum
      end
    end


    def parse_input
      @lines = @file_lines.map{ |line| line.scan(/\d+/).map(&:to_i)}
    end
  end
end
