require 'toy/point'
require 'toy/position'

module Toy
  class Robot

    def initialize(table:, position: Position::Blank.new, output_stream: STDOUT)
      @table = table
      @position = position
      @output_stream = output_stream
    end

    def place(x_value, y_value, direction)
      if @table.has?(x_value, y_value)
        point = Point.new(x_value: x_value, y_value: y_value)

        @position = Position.new(point: point, direction: direction)
      end
    end

    def report
      if result = @position.report
        @output_stream.puts(result)
      end
    end

    def move
      if position = @position.move
        place(*position.to_a)
      end
    end

    def left
      @position.turn(:left)
    end

    def right
      @position.turn(:right)
    end
  end
end
