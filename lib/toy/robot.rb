# encoding: utf-8

module Toy
  class Robot
    attr_reader :table, :facing

    def initialize(table=Toy::Table.new, direction=Toy::Direction)
      @table = table
      @direction = direction
      @facing = nil
    end

    def place(x, y, facing)
      raise Toy::Direction::Error::DirectionError unless Toy::Direction::DIRECTION.include?(facing)

      @table.hold!(x, y, self)
      @facing = facing
    end

    def placed?
      !!current_unit
    end

    def position
      raise Toy::Robot::Error::PlacementError unless placed?

      [current_unit.x, current_unit.y, @facing]
    end

    def move!
      raise Toy::Robot::Error::PlacementError unless placed?

      place(target.x, target.y, @facing) if target && target.available?
    end

    def turn_left!
      raise Toy::Robot::Error::PlacementError unless placed?

      @facing = @direction.rotate_left(@facing)
    end

    def turn_right!
      raise Toy::Robot::Error::PlacementError unless placed?
      
      @facing = @direction.rotate_right(@facing)
    end

    private

      def current_unit
        @table.unit_collection.find_by_object(self)
      end

      def target
        @table.unit_collection.find_by_direction_of(current_unit.x, current_unit.y, @facing)
      end

    module Error
      class PlacementError < StandardError
        def message
          'Robot is not placed!'
        end
      end
    end
  end
end
