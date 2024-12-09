require_relative "../utils/part"

module Day9
  class Part1 < Part
    def call
      arr = []
      @line.each_slice(2).each_with_index do |(block, space), id|
        arr += [id] * block
        arr += [nil] * space if space
      end

      backwards = arr.reverse.select{|num| num != nil}
      nils_count = arr.count { |num| num == nil }
      arr.map!{|num| num == nil ? backwards.shift : num}
      arr.pop(nils_count)

      result = arr.each_with_index.sum{|num, i| num * i}
      puts "Result: #{result}"
    end

    def parse_input
      @line = @file_lines.first.split("").map(&:to_i)
    end
  end
end
