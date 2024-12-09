require_relative "../utils/part"

module Day9
  class Part2 < Part
    def call
      arr = []
      @line.each_slice(2).each_with_index do |(block, space), id|
        arr << [id, block]
        arr << [nil, space] if space
      end


      # for i in (0..arr.size-1).reverse_each do
      #   num, count = arr[i]
      #   next if num == nil
      #   for j in 0..i-1
      #     id, c = arr[j]
      #     puts "id: #{id}, c: #{c}"
      #     next unless id == nil
      #     next unless c <= count
      #     arr[i] = [nil, count]
      #     arr[j] = [num, count]
      #     arr.insert(j+1, [nil, count - c]) if count > c
      #   end
      #   puts "Num: #{num}, Count: #{count}"
      #   break
      # end
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
