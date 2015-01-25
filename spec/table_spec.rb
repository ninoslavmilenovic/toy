# encoding: utf-8

require 'spec_helper'

describe Toy::Table do
  let(:table) { Toy::Table.new }

  describe '#unit_collection' do
    specify { expect(table.unit_collection.all.size).to eq(25) }
  end

  describe '#hold!' do
    let!(:object1) { "Object1" }
    let!(:object2) { "Object2" }
    let!(:unit1) { table.unit_collection.find_by_coordinates(0, 0) }
    let!(:unit2) { table.unit_collection.find_by_coordinates(0, 1) }

    context 'when unit is available' do
      before { table.hold!(unit1.x, unit1.y, object1) }

      specify { expect(table.unit_collection.find_by_object(object1)).to eq(unit1) }
      specify do 
        table.hold!(unit2.x, unit2.y, object1)
        expect(unit1.object).to eq(nil)
      end
    end

    context 'when unit is not available' do
      before { table.hold!(unit1.x, unit1.y, object1) }

      specify do
        expect { table.hold!(unit1.x, unit1.y, object2) }.to \
          raise_error(Toy::Table::Error::TableError, 'Unit is not available.')
      end
    end
  end
end
