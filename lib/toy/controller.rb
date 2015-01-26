# encoding: utf-8

module Toy
  class Controller
    COMMANDS = %w[STOP HELP PLACE MOVE LEFT RIGHT REPORT]

    attr_reader :robot

    def initialize
      @robot = Robot.new
    end

    def start
      while command = gets
        unless COMMANDS.include?(command.gsub(/^[A-Z]+/).first)
          puts 'Invalid command! Type HELP for list of available commands.' and next
        end

        case command
          when /STOP/
            break
          else
            output = execute(command.strip)
            puts output if output
        end          
      end
    end

    private

      def execute(command)
        case command
          when /HELP/
            help
          when /PLACE/
            place(command)
          when /MOVE/
            move
          when /LEFT/
            left
          when /RIGHT/
            right
          when /REPORT/
            report
        end
      end

      def help
        "Available commands: #{COMMANDS.join(' ')}"
      end

      def place(command)
        general_error_message = 'Invalid placement arguments!'
        begin
          x, y, facing = command.split(' ', 2).last.split(',')

          x = x.to_i if x.strip.match(/^(\d)+$/)
          y = y.to_i if y.strip.match(/^(\d)+$/)
          facing = facing.strip.downcase.to_sym
        rescue
          return general_error_message
        end

        begin
          @robot.place(x, y, facing) and return nil
        rescue Toy::Direction::Error::DirectionError => e
          e.message
        rescue Toy::Unit::Error::CoordinateError => e
          e.message
        rescue Toy::Table::Error::TableError
          "Already taken!"
        rescue
          general_error_message
        end
      end

      def move
        @robot.move! and return nil
      rescue Toy::Robot::Error::PlacementError => e
        e.message
      end

      def left
        @robot.turn_left! and return nil
      rescue Toy::Robot::Error::PlacementError => e
        e.message
      end

      def right
        @robot.turn_right! and return nil
      rescue Toy::Robot::Error::PlacementError => e
        e.message
      end

      def report
        x, y, facing = @robot.position
        "#{x},#{y},#{facing.upcase}"
      rescue Toy::Robot::Error::PlacementError => e
        e.message
      end
  end
end