require_relative 'base'

module Hexagonal::Coordinate
  class Cube < Base
    def x; coords[0]; end
    def y; coords[1]; end
    def z; coords[2]; end

    def ==(coord)
      coords == coord.coords
    end

    def to_axial
      Axial.new(x, z)
    end

    def to_cube
      self
    end

    def to_even_q
      q = x
      r = z + ((x + (x % 2)) / 2)
      Offset::EvenQ.new(q, r)
    end

    def to_even_r
      q = x + ((z + (z % 2)) / 2)
      r = z
      Offset::EvenR.new(q, r)
    end

    def to_odd_q
      q = x
      r = z + ((x - (x % 2)) / 2)
      Offset::OddQ.new(q, r)
    end

    def to_odd_r
      q = x + ((z - (z % 2)) / 2)
      r = z
      Offset::OddR.new(q, r)
    end
  end
end
