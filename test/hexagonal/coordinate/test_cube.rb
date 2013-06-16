require 'test_helper'

require 'hexagonal/coordinate/cube'

class TestCube < Minitest::Test
  def setup
    @origin = Hexagonal::Coordinate::Cube.new(0, 0, 0)
    @cube = Hexagonal::Coordinate::Cube.new(1, -3, 2)
  end

  def test_neighbors
    assert_equal [[2, -4, 2], [2, -3, 1], [1, -2, 1],
                  [0, -2, 2], [0, -3, 3], [1, -4, 3]],
                 @cube.neighbors.map(&:coordinates)
  end
end
