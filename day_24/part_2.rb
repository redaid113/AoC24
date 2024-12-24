require_relative "../utils/part"
require 'rgl/adjacency'
require 'rgl/dot'

module Day24
  class Part2 < Part
    def call
      # print_graph(@gates)

      result = File.open("./day_24/answer.txt").read.strip.split(", ").sort.join(",")
      puts "Result: #{result}"
    end

    def analyze_modules
      @connections = {}
      @bad = []
      @gates.each do |output, (a, logic, b)|
        @connections[[a,b]] ||= []
        @connections[[a,b]] << [logic, output]
        @connections[[b,a]] ||= []
        @connections[[b,a]] << [logic, output]
      end

      c = nil
      for i in 0..44
        puts "i: #{i} c: #{c}"
        c = module_correct("x#{i.to_s.rjust(2, "0")}", "y#{i.to_s.rjust(2, "0")}", c)
        puts @bad.to_s if @bad.length > 0
      end
      @bad
    end

    def module_correct(a, b, c)
      return true if c && c[0] == 'z'

      z = a.sub('x', 'z')

      if c == nil
        ab = @connections[[a,b]]
        ab -= [["XOR", z]]
        @bad << z if ab.length == 2
        logic, output = ab[0]

        @bad << output if logic != "AND"
        return output

        # A XOR B -> Z
        # A AND B -> C
      else
        # A XOR B -> q
        # A AND B -> w
        #
        # C XOR q -> Z
        # C AND q -> e
        #
        # e OR w -> C
        ab = @connections[[a,b]]
        q = ab.find{|l, o| l == 'XOR'}[1]
        w = ab.find{|l, o| l == 'AND'}[1]

        cq = @connections[[c,q]]
        cq -= [["XOR", z]]

        @bad << z if cq.length == 2

        l, e = cq[0]
        @bad << e if l != "AND"

        l, c = @connections[[e, w]].first
        @bad << c if l != "OR"
        return c
      end
    end

    def print_graph(gates)
      graph = RGL::DirectedAdjacencyGraph[]
      gates.to_a.each do |output, (a, logic, b)|
        gate = output[0] == 'z' ? "#{logic} #{output}" : output
        graph.add_edge(a, gate)
        graph.add_edge(b, gate)
        graph.add_edge(gate, output) if output[0] == 'z'
        graph.set_vertex_options(gate, shape: 'box', label: "#{logic}: #{gate}", fontsize: 10)
      end

      graph.write_to_graphic_file('png', 'day_24/graph')
    end

    def parse_input
      @wires = {}
      @paragraphs.first.split("\n").each do |wire|
        key, value = wire.split(": ")
        @wires[key] = value.to_i
      end

      @gates = {}

      @paragraphs.last.split("\n").each do |line|
        equation, output = line.split(" -> ")
        a, logic, b = equation.split(" ")
        @wires[output] ||= nil
        @wires[a] ||= nil
        @wires[b] ||= nil

        @gates[output] = [a, logic, b]
      end
    end
  end
end
