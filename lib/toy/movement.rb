module Toy
  module Movement
    def movements
      @movements ||= {
        'NORTH' => { right: 'EAST',  left: 'WEST',  x:  0, y:  1 },
        'EAST'  => { right: 'SOUTH', left: 'NORTH', x:  1, y:  0 },
        'SOUTH' => { right: 'WEST',  left: 'EAST',  x:  0, y: -1 },
        'WEST'  => { right: 'NORTH', left: 'SOUTH', x: -1, y:  0 },
      }
    end

    def directions
      movements.keys
    end
  end
end
