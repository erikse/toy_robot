require 'toy/interpreter'

RSpec.describe Toy::Interpreter do

  describe '#new' do
    it 'raises a NoMethodError' do
      expect { Toy::Interpreter.new }.to raise_error(NoMethodError)
    end
  end

  describe '#instance' do
    context 'given a Toy::Interpreter instance' do
      subject(:interpreter) { Toy::Interpreter.instance }

      it 'returns the same instance' do
        expect(Toy::Interpreter.instance.equal?(interpreter)).to be true
      end
    end
  end

  describe '.configure' do
    it 'raises an ArgumentError unless a block is given' do
      expect { Toy::Interpreter.configure }.to raise_error(ArgumentError)
    end

    context 'given an empty block' do
      it 'create an instance of Toy::Interpreter' do
        expect(Toy::Interpreter).to receive(:instance)

        Toy::Interpreter.configure { }
      end
    end

    context 'given a block containing a match decleration' do
      let(:interpreter) { Toy::Interpreter.instance }

      it 'calls self.match with the configured arguments' do
        expect(interpreter).to receive(:match).with(/MOVE/, { to: '#move' })

        Toy::Interpreter.configure do
          match /MOVE/, to: '#move'
        end
      end
    end
  end

  describe '#match' do
    subject(:interpreter) { Toy::Interpreter.instance }

    it 'raises ArgumentError when the first arg doesnt respond to match' do
      expect { interpreter.match(nil, to: '#move') }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError when the to: argument does match #method_name' do
      expect { interpreter.match(/MOVE/, to: '$move') }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError when the to: argument is not a method on Toy::Robot' do
      expect { interpreter.match(/MOVE/, to: '#swim') }.to raise_error(ArgumentError)
    end
  end

  describe '#run' do
    subject(:interpreter) { Toy::Interpreter.instance }

    context 'given a an input_stream with commands' do
      let(:input_stream) { ['MOVE', 'LEFT'] }
      let(:toy_robot) { double }

      it 'iterates the input_stream & invokes run_command with each line' do
        expect(interpreter).to receive(:run_command).with('MOVE', toy_robot)
        expect(interpreter).to receive(:run_command).with('LEFT', toy_robot)

        interpreter.run(input_stream, toy_robot)
      end
    end
  end

  describe '#run_command' do
    context 'given a configured interpreter and toy_robot' do
      before(:each) do
        Toy::Interpreter.configure do
          match(/MOVE/, to: '#move')
        end
      end

      context 'and a valid command' do
        let(:toy_robot) { double }

        it 'invokes the configured method_name on the toy_robot' do
          expect(toy_robot).to receive(:move)

          Toy::Interpreter.instance.run_command('MOVE', toy_robot)
        end
      end

      context 'and an invalid command' do
        let(:toy_robot) { double 'should not be invoked' }

        it 'it ignores the command' do
          Toy::Interpreter.instance.run_command('UP', toy_robot)
        end
      end
    end
  end
end
