require 'toy/table'

RSpec.describe Toy::Table do

  describe '#has?' do
    context 'given a table with valid width & height values' do
      subject(:table) { Toy::Table.new(width: 3, height: 3) }

      it 'returns true for all valid x and y values' do
        table.width_values.zip(table.height_values) do |x, y|
          expect(table.has?(x, y)).to be true
        end
      end

      it 'returns false for an x_value too low' do
        too_low = table.width_values.min - 1
        expect(table.has?(too_low, 0)).to be false
      end

      it 'returns false for an x_value too high' do
        too_high = table.width_values.max + 1
        expect(table.has?(too_high, 0)).to be false
      end

      it 'returns false for an y_value too low' do
        too_low = table.height_values.min - 1
        expect(table.has?(0, too_low)).to be false
      end

      it 'returns false for an y_value too high' do
        too_high = table.height_values.max + 1
        expect(table.has?(0, too_high)).to be false
      end
    end
  end

  describe '#width_values' do
    context 'given a table with a width & height of 2' do
      subject(:table) { Toy::Table.new(width: 2, height: 2) }

      it 'returns a range 0..1' do
        expect(table.width_values).to eq (0..1)
      end
    end
  end

  describe '#height_values' do
    context 'given a table with a width & height of 2' do
      subject(:table) { Toy::Table.new(width: 2, height: 2) }

      it 'returns a range 0..1' do
        expect(table.height_values).to eq (0..1)
      end
    end
  end
end
