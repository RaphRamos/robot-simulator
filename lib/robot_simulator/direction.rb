# frozen_string_literal: true

module Direction
  class DirectionError < StandardError; end

  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

  def self.validate!(direction)
    raise DirectionError, "Direction '#{direction}' is not valid." unless DIRECTIONS.include?(direction)

    true
  end

  def self.left_from(direction)
    validate!(direction)

    index = DIRECTIONS.index(direction)
    DIRECTIONS[index - 1]
  end

  def self.right_from(direction)
    validate!(direction)

    # making use of Ruby's negative indices
    index = DIRECTIONS.index(direction) - DIRECTIONS.size
    DIRECTIONS[index + 1]
  end
end
