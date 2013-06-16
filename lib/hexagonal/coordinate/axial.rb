require_relative 'base'

module Hexagonal::Coordinate
  class Axial < Base
    def q; coords[0]; end
    def r; coords[1]; end

    def to_cube
      x = q
      z = r
      y = -x - z
      Cube.new(x, y, z)
    end
  end
end
