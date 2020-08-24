# frozen_string_literal: true

class ApplicationError < StandardError; end
class Application
  attr_reader :board, :robot

  COMMANDS = %w[PLACE MOVE REPORT LEFT RIGHT].freeze

  def initialize
    @board = Board.new
  end

  def validate!(command)
    raise ApplicationError, 'Command invalid.' unless COMMANDS.include?(command)
  end

  def place(x_axis, y_axis, direction)
    return unless board.within_boundaries?([x_axis, y_axis]) && Direction.valid?(direction)

    @robot = Robot.new(direction: direction)
    board.update_robot_position([x_axis, y_axis])
  end

  def move
    return if robot.nil? || board.nil?

    new_position = robot.move_from(board.robot_position)
    board.update_robot_position(new_position)
  end

  def report
    return if robot.nil?

    "#{board.robot_position.join(',')},#{robot.direction}"
  end

  def left
    return if robot.nil?

    robot.turn_left
  end

  def right
    return if robot.nil?

    robot.turn_right
  end
end
