require_relative '../base'

module Hexagonal
  module Coordinate
    module Offset
      class Base < Base
        def q; coords[0]; end
        def r; coords[1]; end
      end
    end
  end
end
