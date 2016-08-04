require 'singleton'

require 'toy/robot'

module Toy
  class Interpreter
    include Singleton

    def initialize
      @matches = {}
    end

    def self.configure(&block)
      unless block_given?
        raise ArgumentError.new("expected a block argument")
      end

      Interpreter.instance.instance_eval(&block)
    end

    def match(regex, to:)
      unless regex.respond_to?(:match)
        raise ArgumentError.new("expected first argument to be a Regexp")
      end

      unless to =~ /#.+/
        raise ArgumentError.new("expected to: argument '#{to}', to match format /#method_name/")
      end

      method_name = to.sub("#", '')

      unless Toy::Robot.instance_methods.include?(method_name.to_sym)
        raise ArgumentError.new("expected to: argument '#{to}', be a method on Toy::Robot")
      end

      @matches[regex] = { method_name: method_name }
    end

    def run(input_stream, toy_robot)
      input_stream.each do |line|
        run_command(line, toy_robot)
      end
    end

    def run_command(line, toy_robot)
      @matches.each do |regex, target|
        if match = regex.match(line)
          toy_robot.send(target[:method_name], *match.captures)
        end
      end
    end
  end
end
