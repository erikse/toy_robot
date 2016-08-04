require_relative 'shared_examples/movements'

require 'toy/position'

RSpec.describe Toy::Position do
  include_examples 'movements', Toy::Position

  describe '#turn' do
    let(:point) { Toy::Point.new(x_value: 0, y_value: 0) }

    context 'given a position with a valid direction' do
      subject(:position) { Toy::Position.new(point: point, direction: 'NORTH') }

      it 'changes the direction for a valid towards arg' do
        [:left, :right].each do |towards|
          expect { position.turn(towards) }.to change(position, :to_a)
        end
      end

      it 'does not change the direction for an invalid towards arg' do
        expect { position.turn(:forward) }.to_not change(position, :to_a)
      end
    end

    context 'given a position with an invalid direction' do
      subject(:position) { Toy::Position.new(point: point, direction: 'UP') }

      it 'does not change the direction' do
        expect { position.turn(:right) }.to_not change(position, :to_a)
      end
    end
  end

  describe '#move' do
    let(:point) { double }
    subject(:position) { Toy::Position.new(point: point, direction: 'EAST') }

    it 'asks a point to move' do
      expect(point).to receive(:move)

      position.move
    end

    context 'given a point#move returns a result' do

      before(:each) do
        allow(point).to receive(:move) { Toy::Point.new(x_value: 2, y_value: 2) }
      end

      it 'returns a new position' do
        expect(position.move.equal?(position)).to be false
      end
    end

    context 'given point#move returns nothing' do

      before(:each) do
        allow(point).to receive(:move) { nil }
      end

      it 'returns itself' do
        expect(position.move.equal?(position)).to be true
      end
    end
  end

  describe '#report' do
    subject(:position) { Toy::Position.new(point: double, direction: 'EAST') }

    before(:each) do
      allow(position).to receive(:to_a) { [1, 2, 'EAST'] }
    end

    it 'joins the results of self#to_a into a commas separated String of values' do
      expect(position.report).to eq "1,2,EAST"
    end
  end

  describe '#to_a' do
    let(:point) { double }
    subject(:position) { Toy::Position.new(point: point, direction: 'EAST') }

    before(:each) do
      allow(point).to receive(:to_a) { [1,2] }
    end

    it 'returns an array appending point values & direction' do
      expect(position.to_a).to eq [1, 2, 'EAST']
    end
  end
end

RSpec.describe Toy::Position::Blank do
  subject(:position) { Toy::Position::Blank.new }

  describe '#turn' do
    it 'returns nil' do
      expect(position.turn('NORTH')).to be_nil
    end
  end

  describe '#move' do
    it 'returns nil' do
      expect(position.move).to be_nil
    end
  end

  describe '#report' do
    it 'returns nil' do
      expect(position.report).to be_nil
    end
  end
end
