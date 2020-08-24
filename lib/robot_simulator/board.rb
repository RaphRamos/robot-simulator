# frozen_string_literal: true

class Board
  attr_reader :dimension, :robot_position

  def initialize
    @dimension = [5, 5]
    @robot_position = [0, 0]
    validate!
  end

  def within_boundaries?(position)
    return false if position[0].negative? || position[0] >= dimension[0]
    return false if position[1].negative? || position[1] >= dimension[1]

    true
  end

  def update_robot_position(position)
    @robot_position = position if within_boundaries?(position)
  end

  def validate!
    unless dimension[0].is_a?(Integer) && dimension[0].positive?
      raise ArgumentError, 'X axis is not a positive integer.'
    end

    return if dimension[1].is_a?(Integer) && dimension[1].positive?

    raise ArgumentError, 'Y axis is not a positive integer.'
  end
end
