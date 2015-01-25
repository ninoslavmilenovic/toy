# encoding: utf-8

require 'spec_helper'

describe Toy::Robot do
  let(:robot) { Toy::Robot.new }

  describe '#facing' do
    context 'when placed' do
      before { robot.place(0, 0, :north) }

      specify { expect(robot.facing).to eq(:north) }
    end

    context 'when not placed' do
      specify { expect(robot.facing).to eq(nil) }
    end
  end

  describe '#table' do
    specify { expect(robot.table.is_a?(Table)).to eq(true) }
  end

  describe '#place' do
    context 'when valid arguments' do
      before { robot.place(0, 0, :north) }

      specify { expect(robot.facing).to eq(:north) }
      specify { expect(robot.position).to eq([0, 0, :north]) }
    end

    context 'when invalid direction' do
      specify do 
        expect { robot.place(0, 0, :invalid) }.to \
          raise_error Toy::Direction::Error::DirectionError, 'Invalid direction!'
      end
    end

    context 'when invalid coordinate' do
      specify do 
        expect { robot.place(:invalid, 0, :north) }.to \
          raise_error(Toy::Unit::Error::CoordinateError, 'Coordinates must be of type Fixnum!')
      end

      specify do 
        expect { robot.place(0, :invalid, :north) }.to \
          raise_error(Toy::Unit::Error::CoordinateError, 'Coordinates must be of type Fixnum!')
      end
    end
  end

  describe '#placed?' do
    context 'when placed' do
      before { robot.place(0, 0, :north) }

      specify { expect(robot.placed?).to eq(true) }
    end

    context 'when not placed' do
      specify { expect(robot.placed?).to eq(false) }
    end
  end

  describe '#position' do
    context 'when placed' do
      before { robot.place(0, 0, :north) }

      specify { expect(robot.position).to eq([0, 0, :north]) }
    end

    context 'when not placed' do
      specify do
        expect { robot.position }.to \
          raise_error(Toy::Robot::Error::PlacementError, 'Robot is not placed!')
      end
    end
  end

  describe '#move!' do
    context 'when placed' do
      context 'when target unit is available' do
        before do 
          robot.place(0, 0, :north) 
          robot.move!
        end

        specify { expect(robot.position).to eq([0, 1, :north]) }
      end

      context 'when target unit is not available' do
        before do 
          robot.place(0, 0, :south) 
          robot.move!
        end

        specify { expect(robot.position).to eq([0, 0, :south]) }
      end
    end

    context 'when not placed' do
      specify do 
        expect { robot.move! }.to \
          raise_error(Toy::Robot::Error::PlacementError, 'Robot is not placed!')
      end
    end
  end

  describe '#turn_left!' do
    context 'when placed' do
      before do 
        robot.place(0, 0, :north)
        robot.turn_left!
      end

      specify { expect(robot.position).to eq([0, 0, :west]) }
    end

    context 'when not placed' do
      specify do 
        expect { robot.turn_left! }.to \
          raise_error(Toy::Robot::Error::PlacementError, 'Robot is not placed!')
      end
    end
  end

  describe '#turn_right!' do
    context 'when placed' do
      before do 
        robot.place(0, 0, :north)
        robot.turn_right!
      end

      specify { expect(robot.position).to eq([0, 0, :east]) }
    end

    context 'when not placed' do
      specify do 
        expect { robot.turn_right! }.to \
          raise_error(Toy::Robot::Error::PlacementError, 'Robot is not placed!')
      end
    end
  end
end
