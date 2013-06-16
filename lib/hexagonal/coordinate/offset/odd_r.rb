require_relative 'base'

module Hexagonal::Coordinate
  module Offset
    class OddR < Base
      def to_cube
        x = q - ((r - (r % 2)) / 2)
        z = r
        y = -x - z
        Cube.new(x, y, z)
      end
    end
  end
end
