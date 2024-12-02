require_relative "./utils/callable"

class SetupDay
  extend Callable
  def initialize(day:)
    @day = "day_#{day}"
  end

  def call
    create_directory
    create_part(1)
    create_part(2)
    create_input_file
    create_test_file
  end

  def create_directory
    return if File.directory?("#{__dir__}/#{@day}")

    Dir.mkdir("#{__dir__}/#{@day}")
  end

  def create_part(part)
    create_file("part_#{part}.rb", part_template(part))
  end

  def create_input_file
    create_file("input.txt", "")

  end

  def create_test_file
    create_file("test.txt", "")
  end

  def create_file(file_name, content)
    path = "#{__dir__}/#{@day}/#{file_name}"
    return if File.exist?(path)
    File.open(path, "w") do |file|
      file.write(content)
    end
  end

  def part_template(part)
    <<~TEMPLATE
      require_relative "../utils/part"

      module #{@day.capitalize}
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

end
