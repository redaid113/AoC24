require_relative "../utils/part"

module Day22
  class Part1 < Part
    def call
      result = @secrets.sum do|secret|
        (1..2000).each do
          secret = psuedo_random(secret)
        end
        secret
      end
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
