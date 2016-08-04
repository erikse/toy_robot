require_relative 'shared_examples/movements'

require 'toy/point'

RSpec.describe Toy::Point do
  include_examples 'movements', Toy::Point

  describe '#to_a' do
    subject(:point) { Toy::Point.new(x_value: 3, y_value: 3) }

    it 'returns an array with x_value & y_value' do
      expect(point.to_a).to eq [3, 3]
    end
  end

  describe '#move' do
    let(:point) { Toy::Point.new(x_value: 1, y_value: 1) }

    context 'given a move to the NORTH' do
      it 'returns a new Point with a y value increased by 1' do
        expect(point.move("NORTH").to_a).to eq [1, 2]
      end
    end

    context 'given a move to the SOUTH' do
      it 'returns a new Point with a y value decreased by 1' do
        expect(point.move("SOUTH").to_a).to eq [1, 0]
      end
    end

    context 'given a move to the EAST' do
      it 'returns a new Point with an x value increased by 1' do
        expect(point.move("EAST").to_a).to eq [2, 1]
      end
    end

    context 'given a move to the WEST' do
      it 'returns a new Point with an x value decreased by 1' do
        expect(point.move("WEST").to_a).to eq [0, 1]
      end
    end

    context 'given a move to an invalid direction' do
      it 'returns itself' do
        expect(point.move('UP')).to eq point
      end
    end
  end
end
