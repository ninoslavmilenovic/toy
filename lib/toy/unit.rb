# encoding: utf-8

module Toy
  class Unit
    attr_reader :table, :x, :y, :object

    def initialize(x, y, table=Toy::Table.new)
      raise Toy::Unit::Error::CoordinateError unless x.is_a?(Fixnum)
      raise Toy::Unit::Error::CoordinateError unless y.is_a?(Fixnum)
      raise Toy::Unit::Error::TableError unless table.is_a?(Table)

      @table = table
      @x = x
      @y = y
      @object = nil
    end

    def hold!(object)
      @object = object
    end

    def release!
      @object = nil
    end

    def available?
      @object.nil?
    end

    module Error
      class CoordinateError < ArgumentError
        def message
          'Coordinates must be of type Fixnum!'
        end
      end

      class TableError < ArgumentError
        def message
          'Table must be of type Table!'
        end
      end
    end
  end
end
