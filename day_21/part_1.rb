require_relative "../utils/part"

module Day21
  class Part1 < Part
    KEYPAD = [
      ['7','8','9'],
      ['4','5','6'],
      ['1','2','3'],
      [nil, '0', 'A']
    ]
    ARROWS = [
      [nil, '^', 'A'],
      ['<', 'v', '>']
    ]

    def call
      result = @file_lines.sum do |line|
        length = gimmie_the_length(line)
        value = line.scan(/\d+/).first.to_i
        length * value
      end

      puts "Result: #{result}"
    end

    def gimmie_the_length(code)
      current = 'A'

      code.chars.sum do |char|
        paths = possible_paths(current, char, @keypad_map, KEYPAD)
        current = char
        paths.map{|path| min_length(path, 2)}.min
      end
    end

    def min_length(path, depth)
      @min_length ||= {}
      @min_length[[path, depth]] ||= min_length_implementation(path, depth)
    end

    def min_length_implementation(code, depth)
      return code.length if depth == 0

      current = 'A'
      code.sum do |char|
        paths = possible_paths(current, char, @arrows_map, ARROWS)
        current = char
        paths.map{|path| min_length(path, depth - 1)}.min
      end
    end


    def possible_paths(from, to, map, pad)
      @paths ||= {}
      @paths[[from, to]] ||= possible_paths_implementation(from, to, map, pad)
    end

    def possible_paths_implementation(from, to, map, pad)
      from_x, from_y = map[from]
      to_x, to_y = map[to]

      diff_x = to_x - from_x
      diff_y = to_y - from_y

      y_change = []
      if diff_y > 0
        y_change += ['v'] * diff_y
      elsif diff_y < 0
        y_change += ['^'] * diff_y.abs
      end

      x_change = []
      if diff_x > 0
        x_change += ['>'] * diff_x
      elsif diff_x < 0
        x_change += ['<'] * diff_x.abs
      end

      return [['A']] if diff_y == 0 && diff_x == 0
      return [y_change + ['A']] if diff_x == 0
      return [x_change + ['A']] if diff_y == 0

      return [x_change + y_change + ['A']] if pad[to_y][from_x] == nil
      return [y_change + x_change + ['A']] if pad[from_y][to_x] == nil
      return [x_change + y_change + ['A'], y_change + x_change + ['A']]
    end


    def convert_to_map(array)
      map = {}
      array.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          map[cell] = [x, y] if cell
        end
      end
      map
    end

    def parse_input
      @keypad_map = convert_to_map(KEYPAD)
      @arrows_map = convert_to_map(ARROWS)
    end
  end
end
