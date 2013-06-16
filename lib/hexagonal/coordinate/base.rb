module Hexagonal::Coordinate
  class Base
    def self.[](*coords)
      self.new(*coords)
    end

    attr_reader :coords

    def initialize(*coords)
      @coords = coords
    end

    def ==(coord)
      self.to_cube == coord.to_cube
    end

    %w[ axial even_q even_r odd_q odd_r ].each do |coordinate_system|
      method = "to_#{coordinate_system}"
      define_method(method) { self.to_cube.send(method) }
    end

    def to_cube
      raise NotImplementedError
    end

    def to_s
      "#{self.class.name.split('::').last}#{coords.to_a}"
    end
  end
end
