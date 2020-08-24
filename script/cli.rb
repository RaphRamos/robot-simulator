# frozen_string_literal: true

# Command Line Interface for Robot Simulator
$LOAD_PATH.push File.join(File.dirname(__FILE__), '/../lib')
require 'robot_simulator'

EXIT_COMMANDS = %w[QUIT Q EXIT].freeze
CLI_COMMANDS = [
  { name: :place, format: /^PLACE (\d+),(\d+),(#{Direction::DIRECTIONS.join('|')})/ },
  { name: :move, format: /^MOVE/ },
  { name: :left, format: /^LEFT/ },
  { name: :right, format: /^RIGHT/ },
  { name: :report, format: /^REPORT/ }
].freeze

def main
  puts 'Starting ROBOT SIMULATOR...'
  app = Application.new
  if ARGV.empty?
    show_usage
    run_interactive(app)
  else
    run_script(app, ARGV[0])
  end
  puts 'Exiting ROBOT SIMULATOR...'
end

def execute(app, command_name, args = [])
  case command_name
  when :place
    x_axis, y_axis, direction = args
    app.place(x_axis.to_i, y_axis.to_i, direction)
  when :report
    puts app.report unless app.report.nil?
  else
    app.send(command_name)
  end
end

def get_command_from_input(input)
  command = CLI_COMMANDS.find { |cmd| input =~ cmd[:format] }
  return if command.nil?

  # if the regex contains captures, pass them as args
  args = input.match(command[:format]).captures
  [command, args]
end

def run_interactive(app)
  loop do
    input = gets.chomp.upcase
    break if EXIT_COMMANDS.include?(input)

    command, args = get_command_from_input(input)
    if command.nil?
      show_usage
      next
    end
    execute(app, command[:name], args)
  end
end

def run_script(app, file_path)
  File.readlines(file_path).each do |line|
    next if line.empty?

    puts line
    command, args = get_command_from_input(line.upcase)
    next if command.nil?

    execute(app, command[:name], args)
  end
end

def show_usage
  puts <<~COMMAND_USAGE
    Usage: COMMAND [PARAMS]
      Commands:
        PLACE X,Y,DIRECTION
        MOVE
        LEFT
        RIGHT
        REPORT
        (type 'QUIT', 'Q' or 'EXIT' to QUIT)
      Direction:
        NORTH
        EAST
        SOUTH
        WEST
  COMMAND_USAGE
end

main
