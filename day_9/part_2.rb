require_relative "../utils/part"

module Day9
  class Part2 < Part
    def call
      arr = []
      @line.each_slice(2).each_with_index do |(block, space), id|
        arr << [id, block]
        arr << [nil, space] if space
      end

      n = []
      arr.each_with_index do |(num, count), i|
        if num != nil
          n << [num, count]
          arr[i] = [nil, count]
          next
        end

        nil_count = count
        while nil_count > 0
          index = arr.rindex{|id, c| id != nil && c <= nil_count}
          break if index == nil
          id, c = arr[index]
          arr[index] = [nil, c]
          n << [id, c]
          nil_count -= c
        end
        n << [nil, nil_count] if nil_count > 0
      end


      result = 0
      index = 0
      n.each_with_index do |(num, count), i|
        if num != nil
          for c in 0..count-1 do
            result += num * (index + c)
          end
        end
        index += count
      end

      puts "Result: #{result}"
    end

    def parse_input
      @line = @file_lines.first.split("").map(&:to_i)
    end
  end
end
