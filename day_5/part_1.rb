require_relative "../utils/part"

module Day5
  class Part1 < Part
    def call
      result = @updates.select{ |update| valid?(update) }.map{ |update| update[update.size/2] }.sum
      puts "Result: #{result}"
    end

    def valid?(update)
      for i in (update.size - 1).downto(0)
        for k in (i-1).downto(0)
          if @rules[update[i]] && @rules[update[i]].include?(update[k])
            return false
          end
        end
      end
      true
    end

    def parse_input
      first, second = @input.split("\n\n")
      @rules = {}
      first.split("\n").map{ |line| line.split("|").map(&:to_i) }.each do |x, y|
        @rules[x] ||= []
        @rules[x] << y
      end
      @updates = second.split("\n").map{ |line| line.split(",").map(&:to_i) }
    end
  end
end
