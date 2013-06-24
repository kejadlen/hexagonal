require 'test_helper'

require 'hexagonal/coordinate'

class TestCoordinates < Minitest::Test
  TYPES = %w[     axial   cube      even_q  even_r  odd_q    odd_r ]
  COORDINATES = [[[0,-1], [0,1,-1], [0,-1], [0,-1], [0,-1],  [-1,-1]],
                 [[0,0],  [0,0,0],  [0,0],  [0,0],  [0,0],   [0,0]],
                 [[0,1],  [0,-1,1], [0,1],  [1,1],  [0,1],   [0,1]],
                 [[1,-1], [1,0,-1], [1,0],  [1,-1], [1,-1],  [0,-1]],
                 [[1,0],  [1,-1,0], [1,1],  [1,0],  [1,0],   [1,0]],
                 [[-1,0], [-1,1,0], [-1,0], [-1,0], [-1,-1], [-1,0]],
                 [[-1,1], [-1,0,1], [-1,1], [0,1],  [-1,0],  [-1,1]]]

  def test_from
    cube = Hexagonal::Coordinate::Cube[0,0,0]
    axial = Hexagonal::Coordinate::Axial.from(cube)
    assert_equal [0,0], axial.coordinates
  end

  def test_diagonals
    axial = Hexagonal::Coordinate::Axial[1,2]
    assert_equal [[3,1], [2,0], [0,1], [-1,3], [0,4], [2,3]],
                 axial.diagonals.map(&:coordinates)
  end

  def test_distance_to
    from = Hexagonal::Coordinate::Axial[1,2]
    to = Hexagonal::Coordinate::EvenR[-1,3]
    assert_equal 4, from.distance_to(to)
  end

  def test_line_to
    from = Hexagonal::Coordinate::Axial[1,2]
    to = Hexagonal::Coordinate::EvenR[-1,3]
    # puts from.line_to(to)
  end

  def test_neighbors
    axial = Hexagonal::Coordinate::Axial[1,2]
    assert_equal [[2,2], [2,1], [1,1], [0,2], [0,3], [1,3]],
                 axial.neighbors.map(&:coordinates)
  end

  def test_ring
    origin = Hexagonal::Coordinate::Axial[-1,1]
    assert_equal [[-3,3], [-2,3], [-1,3], [0,2], [1,1], [1,0],
                  [1,-1], [0,-1], [-1,-1], [-2,0], [-3,1], [-3,2]],
                 Hexagonal::Coordinate::Axial.ring(2, origin: origin).map(&:coordinates)
  end

  def test_rotate
    axial = Hexagonal::Coordinate::Axial[-4,2]
    origin = Hexagonal::Coordinate::Axial[1,1]

    assert_equal Hexagonal::Coordinate::Axial[-2,-2],
                 axial.rotate(:clockwise)
    assert_equal Hexagonal::Coordinate::Axial[-1,-4],
                 axial.rotate(:clockwise, origin: origin)
    assert_equal Hexagonal::Coordinate::Axial[-4,5],
                 axial.rotate(:counterclockwise, origin: origin)
  end

  def test_round
  end

  def test_to_coordinates
    COORDINATES.each do |coordinates|
      # convert arrays to coordinates
      meta = TYPES.zip(coordinates).map do |type,coordinate|
        klass = type.split('_').map(&:capitalize).join
        klass = Hexagonal::Coordinate.const_get(klass, false)
        coordinate = klass.new(*coordinate)
        [type, coordinate]
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
