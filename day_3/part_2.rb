require_relative "../utils/part"

module Day3
  class Part2 < Part
    def call
      re = /do\(\)|don't\(\)|mul\(\d+,\d+\)/

      enabled = true
      matches = @file_lines.join("\n").scan(/do\(\)|don't\(\)|mul\(\d+,\d+\)/).select do |match|
        if match == "do()"
          enabled = true
          next(false)
        elsif match == "don't()"
          enabled = false
          next(false)
        end
        if !enabled
          next(false)
        end
        true
      end
      result = matches.join("").scan(/mul\((\d+),(\d+)\)/).sum{|a,b| a.to_i*b.to_i}
      puts "Result: #{result}"
    end
  end
end
