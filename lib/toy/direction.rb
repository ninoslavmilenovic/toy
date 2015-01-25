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
        element(direction, -1)
      end

      def rotate_right(direction)
        element(direction, 1)
      end

      private

        def element(direction, index)
          raise Error::DirectionError unless DIRECTION.include?(direction)

          DIRECTION[(DIRECTION.index(direction) + index) % DIRECTION.size]
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
