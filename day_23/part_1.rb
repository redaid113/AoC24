require_relative "../utils/part"

module Day23
  class Part1 < Part
    def call
      threes = []
      @graph.each do |node, neighbours|
        neighbours.each do |neighbour|
          neighbours_of_neighbours = @graph[neighbour]
          neighbours_of_neighbours
            .select { |n| n != neighbour && n != node && neighbours.include?(n)}
            .each { |n| threes << [node, neighbour, n].sort }
        end
      end

      result = threes.uniq.count { |three| three.any? { |node| node[0] == 't' } }
      puts "Result: #{result}"
    end

    def parse_input
      @graph = {}
      @file_lines.map{|line| line.split('-')}.each do |a, b|
        @graph[a] ||= []
        @graph[a] << b
        @graph[b] ||= []
        @graph[b] << a
      end
    end
  end
end
