require_relative "../utils/part"

module Day24
  class Part1 < Part
    def call

      result = @wires.keys.sort.reverse
        .select{|wire| wire[0] == 'z'}
        .map{|wire| wire_value(wire)}
        .join("")
        .to_i(2)

      puts "Result: #{result}"
    end

    def wire_value(wire)
      return @wires[wire] if @wires[wire].is_a?(Integer)

      a, logic, b = @gates[wire]
      a = wire_value(a)
      b = wire_value(b)

      case logic
      when "AND"
        @wires[wire] = a & b
      when "OR"
        @wires[wire] = a | b
      when "XOR"
        @wires[wire] = a ^ b
      else
        puts "ruh roh"
      end

      @wires[wire]
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
