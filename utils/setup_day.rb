require_relative "./callable"
require 'net/http'

class SetupDay
  extend Callable
  def initialize(day:)
    @day_num = day
    @day = "day_#{day}"
  end

  def call
    create_directory
    create_part(1)
    create_part(2)
    create_input_file
    create_test_file
  end

  private
  def dir
    "#{__dir__}/.."
  end

  def create_directory
    return if File.directory?("#{dir}/#{@day}")

    Dir.mkdir("#{dir}/#{@day}")
  end

  def create_part(part)
    create_file("part_#{part}.rb", part_template(part))
  end

  def create_input_file
    create_file("input.txt", download_input)

  end

  def create_test_file
    create_file("test.txt", "")
  end

  def create_file(file_name, content)
    path = "#{dir}/#{@day}/#{file_name}"
    return if File.exist?(path)
    File.open(path, "w") do |file|
      file.write(content)
    end
  end

  def part_template(part)
    <<~TEMPLATE
      require_relative "../utils/part"

      module #{@day.sub("_", "").capitalize}
        class Part#{part} < Part
          def call
            # Your code here
            result = 0
            puts "Result: \#{result}"
          end

          def parse_input
            # Your code here
          end
        end
      end
    TEMPLATE
  end

  def download_input
    http = Net::HTTP.start('adventofcode.com', 443, use_ssl: true)
    http.get("/2024/day/#{@day_num}/input", headers).body
  end

  def headers
    return {
      'Cookie' => cookie,
      'User-Agent' => 'https://github.com/redaid113/AoC24',
    }
  end

  def cookie
    "session=#{session}"
  end

  def session
    File.read("#{dir}/.session").chomp
  end

end
