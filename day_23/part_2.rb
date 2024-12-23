require_relative "../utils/part"

module Day23
  class Part2 < Part
    def call
      result = largest_group.sort.join(",")
      puts "Result: #{result}"
    end

    def largest_group
      last_groups = @file_lines.map{|line| line.split('-')}
      loop do
        new_groups = groups_n_plus_1(last_groups)
        return last_groups.first if new_groups.empty?
        last_groups = new_groups
      end
    end

    def groups_n_plus_1(groups)
      new_groups = []
      groups.each do |group|
        potential_new_nodes = @graph[group.first]
        potential_new_nodes
          .select{ |node| !group.include?(node) }
          .select{ |node| group.all? { |n| @graph[node].include?(n) } }
          .each do |node|
            new_groups << (group + [node]).sort
          end
      end

      new_groups.uniq
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
