# encoding: utf-8

require 'spec_helper'

describe Toy::UnitCollection do
  let(:unit_collection) { Toy::UnitCollection.new }
  let(:table1) { Toy::Table.new }
  let!(:unit1) { Toy::Unit.new(table=table1, 0, 0) }
  let!(:unit2) { Toy::Unit.new(table=table1, 0, 1) }
  let!(:unit3) { Toy::Unit.new(table=table1, 1, 1) }
  let!(:unit4) { Toy::Unit.new(table=table1, 2, 1) }

  context 'when valid arguments' do
    describe '#add' do
      before do
        unit_collection.add(unit1)
        unit_collection.add(unit2) 
      end

      specify do
        expect(unit_collection.all).to match_array([unit1, unit2])
      end
    end

    describe '#find_by_coordinates' do
      before do 
        unit_collection.add(unit1)
        unit_collection.add(unit2)
      end

      specify do
        expect(unit_collection.find_by_coordinates(0, 1)).to eq(unit2)
      end
    end

    describe '#find_by_object' do
      let!(:object) { "I'm an object" }
      before do 
        unit1.hold!(object)
        unit_collection.add(unit1)
        unit_collection.add(unit2)
      end

      specify do
        expect(unit_collection.find_by_object(object)).to eq(unit1)
      end
    end

    describe '#find_north_of' do
      before do 
        unit_collection.add(unit1)
        unit_collection.add(unit2)
      end

      specify do
        expect(unit_collection.find_north_of(unit1.x, unit1.y)).to eq(unit2)
      end
    end

    describe '#find_east_of' do
      before do 
        unit_collection.add(unit3)
        unit_collection.add(unit4)
      end

      specify do
        expect(unit_collection.find_east_of(unit3.x, unit3.y)).to eq(unit4)
      end
    end

    describe '#find_south_of' do
      before do 
        unit_collection.add(unit1)
        unit_collection.add(unit2)
      end

      specify do
        expect(unit_collection.find_south_of(unit2.x, unit2.y)).to eq(unit1)
      end
    end

    describe '#find_west_of' do
      before do 
        unit_collection.add(unit3)
        unit_collection.add(unit4)
      end

      specify do
        expect(unit_collection.find_west_of(unit4.x, unit4.y)).to eq(unit3)
      end
    end

    describe '#find_by_direction_of' do
      before do 
        unit_collection.add(unit3)
        unit_collection.add(unit4)
      end

      specify do
        expect(unit_collection.find_by_direction_of(unit4.x, unit4.y, :west)).to eq(unit3)
      end
    end
  end

  context 'when invalid arguments' do
    describe '#add' do
      specify do
        expect { unit_collection.add("I'm trying to be Unit") }.to \
          raise_error(Toy::UnitCollection::Error::UnitError, 'Argument must be of type Unit!')
      end
    end

    describe '#find_by_direction_of' do
      before do 
        unit_collection.add(unit3)
        unit_collection.add(unit4)
      end

      specify do
        expect { unit_collection.find_by_direction_of(unit4.x, unit4.y, :invalid) }.to \
          raise_error(Toy::UnitCollection::Error::DirectionError, 'Invalid direction!')
      end
    end
  end
end
