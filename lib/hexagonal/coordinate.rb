module Hexagonal
  module Coordinate
  end
end

require_relative 'coordinate/axial'
require_relative 'coordinate/cube'
require_relative 'coordinate/offset'

module Hexagonal::Coordinate
  EvenQ = Offset::EvenQ
  EvenR = Offset::EvenR
  OddQ = Offset::OddQ
  OddR = Offset::OddR
end
