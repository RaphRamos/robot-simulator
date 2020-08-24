# frozen_string_literal: true

module Direction
  class DirectionError < StandardError; end

  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

  def self.valid?(direction)
    DIRECTIONS.include?(direction)
  end

  def self.left_from(direction)
    raise DirectionError, 'Invalid direction.' unless valid?(direction)

    index = DIRECTIONS.index(direction)
    DIRECTIONS[index - 1]
  end

  def self.right_from(direction)
    raise DirectionError, 'Invalid direction.' unless valid?(direction)

    # making use of Ruby's negative indices
    index = DIRECTIONS.index(direction) - DIRECTIONS.size
    DIRECTIONS[index + 1]
  end
end
