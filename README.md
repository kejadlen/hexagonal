# Hexagonal

Basically a translation of [Hexagonal Grids](http://www.redblobgames.com/grids/hexagons/) into Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'hexagonal'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hexagonal

## Usage

Hexagonal supports the following coordinate systems:

* offset
  * even-q (flat-topped, even columns offset)
  * even-r (pointy-topped, even columns offset)
  * odd-q (flat-topped, odd rows offset)
  * odd-r (pointy-topped, odd rows offset)
* axial
* cube

### Board

``` ruby
board = Hexagonal::Board.new(:axial)

board[2, 1] = 'foo' # pass in coordinates directly

axial = Hexagonal::Coordinate::Axial.new(0, 0) # the same as Hexagonal::Coordinate::Axial[0, 0]
board[axial] = 'bar' # pass in a Hexagonal coordinate
```

### Coordinates

``` ruby
axial = Hexagonal::Coordinate::Axial.new(1, -3)
cube = Hexagonal::Coordinate::Cube.new(1, -2, 1)
even_q = Hexagonal::Coordinate::EvenQ.new(4, -1)
even_r = Hexagonal::Coordinate::EvenR.new(1, 3)
odd_q = Hexagonal::Coordinate::OddQ.new(5, 2)
odd_r = Hexagonal::Coordinate::OddR.new(3, -2)

# conversions
axial.to_cube #=> Cube[1, 2, -3]
cube.to_even_r #> EvenR[2, 1]

# neighbors
even_q.neighbors #=> [EvenQ[5, 0], EvenQ[5, -1], EvenQ[4, -2], EvenQ[3, -1], EvenQ[3, 0], EvenQ[4, 0]]

# diagonals
even_r.diagonals #=> [EvenR[2, 2], EvenR[1, 1], EvenR[-1, 2], EvenR[-1, 4], EvenR[1, 5], EvenR[2, 4]]

# distance
odd_q.distance_to(odd_r) #=> 3

# rotation
axial.rotate(:clockwise, origin: cube) #=> Axial[4,-4]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
