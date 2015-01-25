# encoding: utf-8

require 'spec_helper'

describe Toy::Unit do
  context 'when valid arguments' do
    let(:unit) { Toy::Unit.new(0, 1) }

    describe '#table' do
      specify { expect(unit.table.is_a?(Table)).to eq(true) }
    end
  
    describe '#x' do
      specify { expect(unit.x).to eq(0) }
    end

    describe '#y' do
      specify { expect(unit.y).to eq(1) }
    end

    describe '#object' do
      let!(:object) { "I'm an object" }

      before { unit.hold!(object) }

      specify { expect(unit.object).to eq(object) }
    end

    describe '#available?' do
      context 'when object is not present' do
        specify { expect(unit).to be_available }
      end
    end

    describe '#hold!' do
      before { unit.hold!("I'm an object") }

      specify { expect(unit.object).to eq("I'm an object") }
    end

    describe '#release!' do
      before do 
        unit.hold!("I'm an object")
        unit.release!
      end
      
      specify { expect(unit.object).to be_nil }
    end
  end

  context 'when invalid arguments' do
    specify do 
      expect { Toy::Unit.new("invalid", 0) }.to \
        raise_error(Toy::Unit::Error::CoordinateError, 'Coordinates must be of type Fixnum!')
    end

    specify do 
      expect { Toy::Unit.new(0, "invalid") }.to \
        raise_error(Toy::Unit::Error::CoordinateError, 'Coordinates must be of type Fixnum!')
    end

    specify do
      expect { Toy::Unit.new(0, 0, table=0) }.to \
        raise_error(Toy::Unit::Error::TableError, 'Table must be of type Table!')
    end
  end
end
