require 'test_helper'

require 'hexagonal/coordinate'

class TestCoordinates < Minitest::Test
  TYPES = %w[ axial   cube      even_q  even_r  odd_q    odd_r ]
  COORDS = [[[0,-1], [0,1,-1], [0,-1], [0,-1], [0,-1],  [-1,-1]],
            [[0,0],  [0,0,0],  [0,0],  [0,0],  [0,0],   [0,0]],
            [[0,1],  [0,-1,1], [0,1],  [1,1],  [0,1],   [0,1]],
            [[1,-1], [1,0,-1], [1,0],  [1,-1], [1,-1],  [0,-1]],
            [[1,0],  [1,-1,0], [1,1],  [1,0],  [1,0],   [1,0]],
            [[-1,0], [-1,1,0], [-1,0], [-1,0], [-1,-1], [-1,0]],
            [[-1,1], [-1,0,1], [-1,1], [0,1],  [-1,0],  [-1,1]]]

  def test_to_coordinates
    COORDS.each do |coords|
      # convert arrays to coordinates
      meta = TYPES.zip(coords).map do |type,coord|
        klass = type.split('_').map(&:capitalize).join
        coord = Coordinate.const_get(klass, false).new(*coord)
        [type, coord]
      end

      meta.each do |_, actual|
        meta.each do |type, expected|
          assert_equal expected, actual.send("to_#{type}"),
                       "#{actual}.to_#{type} should be #{expected}"
        end
      end
    end
  end
end
