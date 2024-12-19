require_relative "../utils/part"

module Day19
  class Part1 < Part
    def call
      result = @patterns.count { |pattern| count_towel_patterns(pattern) > 0 }
      puts "Result: #{result}"
    end

    def count_towel_patterns(pattern)
      return 1 if pattern.length == 0
      @count_towel_patterns ||= {}
      @count_towel_patterns[pattern] ||= @towels.sum do |towel|
           pattern.start_with?(towel) ? count_towel_patterns(pattern[towel.length..-1]) : 0
        end
    end

    def parse_input
      @towels = @paragraphs.first.split(", ")
      @patterns = @paragraphs.last.split("\n")
    end
  end
end
