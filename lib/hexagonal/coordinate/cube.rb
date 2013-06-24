require_relative 'base'

module Hexagonal::Coordinate
  class Cube < Base
    DIAGONALS = [[2,-1,-1], [1,1,-2], [-1,2,-1],
                 [-2,1,1], [-1,-1,2], [1,-2,1]]
    NEIGHBORS = [[1,-1,0], [1,0,-1], [0,1,-1],
                 [-1,1,0], [-1,0,1], [0,-1,1]]

    def self.ring(radius, options={})
      origin = options.fetch(:origin, self.new(0, 0, 0))

      h = self.new(-radius, 0, radius)
      ring = (0..5).each.with_object([]) do |i,ring|
        (0...radius).each do |j|
          ring << h
          h = h.neighbors[i]
        end
      end

      ring.map {|coord| coord + origin }
    end

    attr_reader :x, :y, :z

    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z
      super(x, y, z)
    end

    def -(coordinate)
      self.class.new(*self.coordinates.zip(coordinate.to_cube.coordinates).map {|a,b| a - b })
    end

    def +(coordinate)
      self.class.new(*self.coordinates.zip(coordinate.to_cube.coordinates).map {|a,b| a + b })
    end

    def ==(coordinate)
      coordinates == coordinate.to_cube.coordinates
    end

    def diagonals
      DIAGONALS.map do |i,j,k|
        self.class.new(x+i, y+j, z+k)
      end
    end

    def distance_to(coordinate)
      coordinate = coordinate.to_cube
      %w[ x y z ].map {|i| (self.send(i) - coordinate.send(i)).abs }.max
    end

    def line_to(coordinate)
      coordinate = coordinate.to_cube

      # Adjust one endpoint to break ties and make lines look better.
      e = 1e-6
      a = [x+e, y+e, z-2*e]

      d = a.zip(coordinate.coordinates).map {|i,j| i-j }
      n = [d[0]-d[1], d[1]-d[2], d[2]-d[0]].map(&:abs).max

      (0..n).each.with_object([]) do |i,line|
        point = self.coordinates.zip(coordinate.coordinates).map do |a,b|
          a * i/n + b * (1-i/n)
        end
        point = self.class.new(*point).round
        line << point unless line.include?(point)
      end
    end

    def neighbors
      NEIGHBORS.map do |i,j,k|
        self.class.new(x+i, y+j, z+k)
      end
    end

    def rotate(direction, options={})
      origin = options.fetch(:origin, self.class.new(0, 0, 0))
      translated = self - origin.to_cube

      coords = case direction
               when :clockwise
                 [-translated.z, -translated.x, -translated.y]
               when :counterclockwise
                 [-translated.y, -translated.z, -translated.x]
               else
                 raise ArgumentError.new('Direction must be :clockwise or :counterclockwise')
               end
      self.class.new(*coords)
    end

    def round
      r = self.coordinates.map(&:round)
      err = r.zip(self.coordinates).map {|i,j| (i-j).abs }
      if err[0] > err[1] and err[0] > err[2]
        r[0] = -r[1]-r[2]
      elsif err[1] > err[2]
        r[1] = -r[0]-r[2]
      else
        r[2] = -r[0]-r[1]
      end
      self.class.new(*r)
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
