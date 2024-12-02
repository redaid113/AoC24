require_relative "./utils/setup_day"

day = ARGV.shift() || Time.now.day

puts "Creating new day: #{day}"

# Does directory exist?

SetupDay.call(day: day)
