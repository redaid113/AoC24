require_relative "../utils/part"

module Day3
  class Part1 < Part
    def call
      result = @input.scan(/mul\((\d+),(\d+)\)/).sum{|a,b| a.to_i*b.to_i}

      puts "Result: #{result}"
    end
  end
end
