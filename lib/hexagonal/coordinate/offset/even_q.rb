require_relative 'base'

module Hexagonal::Coordinate
  module Offset
    class EvenQ < Base
      def to_cube
        x = q
        z = r - ((q + (q % 2)) / 2)
        y = -x - z
        Cube.new(x, y, z)
      end
    end
  end
end
