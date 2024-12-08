require_relative "../utils/grid"
require_relative "../utils/part"

module Day8
  class Part2 < Part
    def call
      signals = find_signals()
      result = find_all_anodes(signals).size
      puts "Result: #{result}"
    end

    def find_all_anodes(signals)
      anodes = []
      signals.map do |key, coords|
        for i in 0..coords.size - 1 do
          for j in i + 1..coords.size - 1 do
            anodes += calculate_anodes(coords[i], coords[j])
          end
        end
      end
      anodes.uniq
    end

    def calculate_anodes(a, b)
      dr, dc = calculate_diff(a, b)
      all_in_line(a, [dr, dc]) + all_in_line(a, [-dr, -dc]) + [a]
    end

    def calculate_diff(a, b)
      dr = a[0] - b[0]
      dc = a[1] - b[1]
      d = dr.gcd(dc)
      dr /= d
      dc /= d
      [dr, dc]
    end

    def all_in_line(start, diff)
      anodes = []
      cur =  [start[0] + diff[0], start[1] + diff[1]]
      loop do
        break unless in_bounds?(cur)
        anodes << cur
        cur = [cur[0] + diff[0], cur[1] + diff[1]]
      end
      anodes
    end

    def in_bounds?(arr)
      arr[0] >= 0 && arr[0] <= @grid.max_row && arr[1] >= 0 && arr[1] <= @grid.max_col
    end

    def find_signals
      signals = {}
      for r in 0..@grid.max_row do
        for c in 0..@grid.max_col do
          key = @grid.get(r, c)
          next if key == "."
          signals[key] ||= []
          signals[key] << [r, c]
        end
      end
      signals
    end

    def parse_input
      @grid = Grid.new(file_lines: @file_lines)
    end
  end
end
