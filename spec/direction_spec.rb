# encoding: utf-8

require 'spec_helper'

describe Toy::Direction do
  let(:direction) { Toy::Direction }

  describe '.rotate_left' do
    context 'when valid arguments' do
      specify { expect(direction.rotate_left(:north)).to eq(:west) }
      specify { expect(direction.rotate_left(:east)).to eq(:north) }
    end

    context 'when invalid arguments' do
      specify do 
        expect { direction.rotate_left(:invalid) }.to \
          raise_error Toy::Direction::Error::DirectionError, 'Invalid direction!'
      end
    end
  end

  describe '.rotate_right' do
    context 'when valid arguments' do
      specify { expect(direction.rotate_right(:west)).to eq(:north) }
      specify { expect(direction.rotate_right(:east)).to eq(:south) }
    end

    context 'when invalid arguments' do
      specify do 
        expect { direction.rotate_right(:invalid) }.to \
          raise_error Toy::Direction::Error::DirectionError, 'Invalid direction!'
      end
    end
  end
end
