require_relative 'base'

module Hexagonal::Coordinate
  class Cube < Base
    DIAGONALS = [[2,-1,-1], [1,1,-2], [-1,2,-1],
                 [-2,1,1], [-1,-1,2], [1,-2,1]]
    NEIGHBORS = [[1,-1,0], [1,0,-1], [0,1,-1],
                 [-1,1,0], [-1,0,1], [0,-1,1]]

    attr_reader :x, :y, :z

    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z
      super(x, y, z)
    end

    def ==(coordinate)
      coordinates == coordinate.coordinates
    end

    def diagonals
      DIAGONALS.map do |i,j,k|
        self.class.new(x+i, y+j, z+k)
      end
    end

    def neighbors
      NEIGHBORS.map do |i,j,k|
        self.class.new(x+i, y+j, z+k)
      end
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
