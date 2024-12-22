require_relative "../utils/part"

module Day22
  class Part2 < Part
    def call
      prices_array = @secrets.map do|secret|
        prices = [secret % 10]
        (1..2000).each do
          secret = psuedo_random(secret)
          prices << secret % 10
        end
        prices
      end
      sequences_array = prices_array.map do |prices|
        sequence_map = {}
        prices.each_with_index.each_cons(5).each do |(a, ai), (b, bi), (c, ci), (d, di), (e, ei)|
          sequence = [b-a, c-b, d-c, e-d]
          sequence_map[sequence] ||= prices[ei]
        end
        sequence_map
      end
      possible_sequences = sequences_array.map{|sequences| sequences.keys}.flatten(1).uniq
      result = possible_sequences.map{|sequence| sequences_array.sum{|sequences| sequences[sequence] || 0}}.max


      puts "Result: #{result}"
    end

    def psuedo_random(secret)
      secret = (secret ^ (secret * 64)) % 16777216
      secret = (secret ^ (secret / 32)) % 16777216
      (secret ^ (secret * 2048)) % 16777216
    end



    def parse_input
      @secrets = @file_lines.map(&:to_i)
    end
  end
end
