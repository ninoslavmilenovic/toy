# encoding: utf-8

module Toy
  class UnitCollection
    attr_reader :all

    def initialize(direction=Toy::Direction)
      @all = []
      @direction = direction
    end

    def add(unit)
      raise Error::UnitError unless unit.is_a?(Unit)
      
      @all << unit
    end

    def find_by_coordinates(x, y)
      @all.find { |unit| unit.x == x && unit.y == y }
    end

    def find_by_object(object)
      @all.find { |unit| unit.object == object }
    end

    def find_north_of(x, y)
      @all.find { |unit| unit.x == x && unit.y == y.succ }
    end

    def find_east_of(x, y)
      @all.find { |unit| unit.x == x.succ && unit.y == y }
    end

    def find_south_of(x, y)
      @all.find { |unit| unit.x == x && unit.y == y.pred }
    end

    def find_west_of(x, y)
      @all.find { |unit| unit.x == x.pred && unit.y == y }
    end

    def find_by_direction_of(x, y, direction)
      raise Error::DirectionError unless @direction::DIRECTION.include?(direction)

      send("find_#{direction}_of", x, y)
    end

    module Error
      class UnitError < ArgumentError
        def message
          'Argument must be of type Unit!'
        end
      end

      class DirectionError < ArgumentError
        def message
          'Invalid direction!'
        end
      end
    end
  end
end
