# encoding: utf-8

module Toy
  class Table
    X_SIZE = 5
    Y_SIZE = 5

    # X starts from west
    # Y starts from south

    attr_reader :unit_collection

    def initialize(unit=Toy::Unit)
      @unit = unit
      @unit_collection = generate_collection!
    end

    def hold!(x, y, object)
      raise Toy::Unit::Error::CoordinateError unless x.is_a?(Fixnum)
      raise Toy::Unit::Error::CoordinateError unless y.is_a?(Fixnum)

      target_unit = @unit_collection.find_by_coordinates(x, y)

      if target_unit && target_unit.available?
        @unit_collection.find_by_object(object) && @unit_collection.find_by_object(object).release!
        target_unit.hold!(object)
      else 
        raise Toy::Table::Error::TableError
      end
    end

    private

      def generate_collection!
        Toy::UnitCollection.new.tap do |uc|
          Toy::Table::X_SIZE.times do |x|
            Toy::Table::Y_SIZE.times do |y|
              uc.add(@unit.new(x, y, table=self))
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
