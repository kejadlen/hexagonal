module Hexagonal::Coordinate
  class Base
    def self.[](*coordinates)
      self.new(*coordinates)
    end

    def self.from(coordinate)
      type = self.short_name.split(/(?=[A-Z])/).join('_').downcase
      coordinates = coordinate.send("to_#{type}").coordinates
      self.new(*coordinates)
    end

    def self.short_name
      self.name.split('::').last
    end

    attr_reader :coordinates

    def initialize(*coordinates)
      @coordinates = coordinates
    end

    def ==(coordinate)
      self.to_cube == coordinate.to_cube
    end

    def diagonals
      self.to_cube.diagonals.map {|diagonal| self.class.from(diagonal) }
    end

    def neighbors
      self.to_cube.neighbors.map {|neighbor| self.class.from(neighbor) }
    end

    %w[ axial even_q even_r odd_q odd_r ].each do |coordinate_system|
      method = "to_#{coordinate_system}"
      define_method(method) { self.to_cube.send(method) }
    end

    def to_cube
      raise NotImplementedError
    end

    def to_s
      "#{self.class.short_name}#{self.coordinates.to_a}"
    end
  end
end
