require_relative '../base'

module Hexagonal
  module Coordinate
    module Offset
      class Base < Base
        attr_reader :q, :r

        def initialize(q, r)
          @q = q
          @r = r
          super(q, r)
        end
      end
    end
  end
end
