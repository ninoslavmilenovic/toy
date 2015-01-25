# encoding: utf-8

module Toy
  class Direction
    NORTH = :north
    EAST  = :east
    SOUTH = :south
    WEST  = :west

    DIRECTION = [NORTH, EAST, SOUTH, WEST]

    class << self
      def rotate_left(direction)
        raise Error::DirectionError unless DIRECTION.include?(direction)

        DIRECTION[DIRECTION.index(direction).pred % DIRECTION.size]
      end

      def rotate_right(direction)
        raise Error::DirectionError unless DIRECTION.include?(direction)
        
        DIRECTION[DIRECTION.index(direction).succ % DIRECTION.size]
      end
    end
  end

  module Error
    class DirectionError < ArgumentError
      def message
        'Invalid direction!'
      end
    end
  end
end
