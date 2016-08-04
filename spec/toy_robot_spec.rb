require 'toy/robot'

RSpec.describe Toy::Robot do

  describe '#place' do
    let(:table) { double }
    let(:output_stream) { StringIO.new }
    subject(:toy_robot) { Toy::Robot.new(table: table, output_stream: output_stream) }

    context 'given x & y values on the table' do

      before(:each) do
        allow(table).to receive(:has?) { true }
      end

      it 'changes the place of the robot' do
        expect do
          toy_robot.place(0, 0, 'EAST')
          toy_robot.report
        end.to change(output_stream, :string)
      end
    end

    context 'given x & values not on the table' do

      before(:each) do
        allow(table).to receive(:has?) { false }
      end

      it 'does not change the place of the robot' do
        expect do
          toy_robot.place(0, 0, 'EAST')
          toy_robot.report
        end.to_not change(output_stream, :string)
      end
    end
  end

  describe '#report' do
    let(:position) { double }
    subject(:toy_robot) { Toy::Robot.new(table: double, position: position) }

    it 'asks position for the report' do
      expect(position).to receive(:report)
      toy_robot.report
    end

    context 'given position#report returns a result' do
      let(:output_stream) { double }
      subject(:toy_robot) { Toy::Robot.new(table: double, position: position, output_stream: output_stream) }

      before(:each) do
        allow(position).to receive(:report) { '0,1,EAST' }
      end

      it 'writes prints the result to the output_stream' do
        expect(output_stream).to receive(:puts)
        toy_robot.report
      end
    end

    context 'given position#report returns nothing' do
      let(:output_stream) { double 'should not be invoked' }
      subject(:toy_robot) { Toy::Robot.new(table: double, position: position, output_stream: output_stream) }

      before(:each) do
        allow(position).to receive(:report) { nil }
      end

      it 'does not print anything to the output_stream' do
        toy_robot.report
      end
    end
  end

  describe '#move' do
    let(:position) { double }
    subject(:toy_robot) { Toy::Robot.new(table: double, position: position) }

    it 'asks position to move' do
      expect(position).to receive(:move)

      toy_robot.move
    end

    context 'given position#move returns a result' do
      before(:each) do
        allow(position).to receive(:move) { position }
        allow(position).to receive(:to_a) { [1,2,'NORTH'] }
      end

      it 'invokes self#place with the returned position values' do
        expect(toy_robot).to receive(:place)

        toy_robot.move
      end
    end

    context 'given position#move returns nothing' do
      before(:each) do
        allow(position).to receive(:move) { nil }
      end

      it 'does not invoke self#place' do
        expect(toy_robot).to_not receive(:place)

        toy_robot.move
      end
    end
  end

  describe '#left' do
    let(:position) { double }
    subject(:toy_robot) { Toy::Robot.new(table: double, position: position) }

    it 'delegates to position#turn, passing :left as the argument' do
      expect(position).to receive(:turn).with(:left)
      toy_robot.left
    end
  end

  describe '#right' do
    let(:position) { double }
    subject(:toy_robot) { Toy::Robot.new(table: double, position: position) }

    it 'delegates to position#turn, passing :right as the argument' do
      expect(position).to receive(:turn).with(:right)
      toy_robot.right
    end
  end
end
