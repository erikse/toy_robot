require 'toy/movement'

module Toy
  class Position
    extend Movement

    def initialize(point:, direction:)
      @point = point
      @direction = direction
    end

    def turn(towards)
      if direction = self.class.movements.dig(@direction, towards)
        @direction = direction
      end
    end

    def move
      move_point = @point.move(@direction)
      move_point ? self.class.new(point: move_point, direction: @direction) : self
    end

    def report
      self.to_a.join(',')
    end

    def to_a
      @point.to_a << @direction
    end

    class Blank
      def turn(*); end

      [:move, :report].each do |name|
        define_method(name) {}
      end
    end
  end
end
