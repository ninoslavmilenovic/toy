# encoding: utf-8

module Toy
  class Table
    X_SIZE = 5
    Y_SIZE = 5

    # X_STARTS_FROM = WEST
    # Y_STARTS_FROM = SOUTH

    attr_reader :unit_collection

    def initialize(unit=Unit)
      @unit = unit
      @unit_collection = generate_collection!
    end

    def hold!(x, y, object)
      raise @unit::Error::CoordinateError unless x.is_a?(Fixnum)
      raise @unit::Error::CoordinateError unless y.is_a?(Fixnum)

      target_unit = @unit_collection.find_by_coordinates(x, y)

      if target_unit && target_unit.available?
        @unit_collection.find_by_object(object) && @unit_collection.find_by_object(object).release!
        target_unit.hold!(object)
      else 
        raise Error::TableError
      end
    end

    private

      def generate_collection!
        UnitCollection.new.tap do |uc|
          X_SIZE.times do |x|
            Y_SIZE.times do |y|
              uc.add(@unit.new(table=self, x, y))
            end
          end
        end
      end

    module Error
      class TableError < StandardError
        def message
          'Unit is not available.'
        end
      end
    end
  end
end
