# frozen_string_literal: true

class Robot
  attr_reader :direction

  def initialize(direction: Direction::DIRECTIONS.first)
    update_direction(direction)
  end

  def move_from(position)
    new_x_axis, new_y_axis = position

    case direction
    when 'NORTH' then new_y_axis += 1
    when 'EAST' then new_x_axis += 1
    when 'SOUTH' then new_y_axis -= 1
    when 'WEST' then new_x_axis -= 1
    end

    [new_x_axis, new_y_axis]
  end

  def turn_left
    @direction = Direction.left_from(direction)
  end

  def turn_right
    @direction = Direction.right_from(direction)
  end

  def update_direction(direction)
    @direction = direction if Direction.valid?(direction)
  end
end
