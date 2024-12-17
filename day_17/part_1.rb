require_relative "../utils/part"
include Math

module Day17
  class Part1 < Part
    class IntCode
      attr_accessor :A, :B, :C, :instructions, :position, :output
      def initialize(registers, instructions)
        @A = registers[0]
        @B = registers[1]
        @C = registers[2]

        @instructions = instructions

        @position = 0
        @output = []
      end

      def run
        while position < instructions.length
          run_next_instruction
        end
      end

      def run_next_instruction
        optcode = instructions[position]
        operand = instructions[position + 1]

        @position += 2

        case optcode
        when 0 # adv
          @A = dv(operand)
        when 1 # bxl
          @B = @B ^ operand
        when 2 # bst
          @B = combo_operand(operand) % 8
        when 3 # jnz
          return if @A == 0
          @position = operand if operand != @position - 2
        when 4 # bxc
          @B = @B ^ @C
        when 5 # out
          output << combo_operand(operand) % 8
        when 6 # bdv
          @B = dv(operand)
        when 7 # cdv
          @C = dv(operand)
        end

      end

      def dv (operand)
        return 0 if combo_operand(operand) > log(@A, 2)
        return (@A / (2 ** combo_operand(operand))).to_i
      end

      def combo_operand(operand)
        return operand if operand <= 3

        case operand
        when 4
          return @A
        when 5
          return @B
        when 6
          return @C
        when 7
          puts "PANIC"
        end
      end
    end

    def call
      intCode = IntCode.new(@registers, @instructions)
      intCode.run
      result = intCode.output.join(",")
      puts "Result: #{result}"
    end

    def parse_input
      @registers = @paragraphs.first.split("\n").map{ |line| line.scan(/\d+/).first.to_i }
      @instructions = @paragraphs.last.scan(/\d+/).map(&:to_i)
    end
  end
end
