require_relative 'base'

module Hexagonal::Coordinate
  class Axial < Base
    attr_reader :q, :r

    def initialize(q, r)
      @q = q
      @r = r
      super(q, r)
    end

    def to_cube
      x = q
      z = r
      y = -x - z
      Cube.new(x, y, z)
    end
  end
end
