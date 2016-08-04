module Toy
  class Table

    def initialize(width:, height:)
      @width = width
      @height = height
    end

    def has?(x_value, y_value)
      width_values.cover?(x_value.to_i) && height_values.cover?(y_value.to_i)
    end

    def width_values
      (0..@width - 1)
    end

    def height_values
      (0..@height - 1)
    end
  end
end
