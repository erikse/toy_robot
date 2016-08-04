require 'toy/movement'

module Toy
  class Point
    extend Movement

    def initialize(x_value:, y_value:)
      @x_value = x_value.to_i
      @y_value = y_value.to_i
    end

    def move(direction)
      movement = self.class.movements[direction]
      movement ? self.class.new(x_value: @x_value + movement[:x], y_value: @y_value + movement[:y]) : self
    end

    def to_a
      [@x_value, @y_value]
    end
  end
end
