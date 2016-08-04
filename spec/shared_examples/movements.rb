RSpec.shared_examples 'movements' do |klass|

  describe '.directions' do
    it 'returns an array containing each cardinal direction' do
      expect(klass.directions).to include 'NORTH'
      expect(klass.directions).to include 'SOUTH'
      expect(klass.directions).to include 'EAST'
      expect(klass.directions).to include 'WEST'
    end
  end

  describe 'movements' do
    it 'returns a hash with an :x, :y, :left and :right value for each cardinal direction' do
      klass.directions.each do |direction|
        movement = klass.movements[direction]

        expect(movement[:x]).to_not be_nil
        expect(movement[:y]).to_not be_nil
        expect(movement[:left]).to_not be_nil
        expect(movement[:right]).to_not be_nil
      end
    end
  end
end
