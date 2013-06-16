# Hexagonal

Basically a translation of [Hexagonal Grids](http://www.redblobgames.com/grids/hexagons/) to Ruby code.

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

``` ruby
board = Hexagonal::Board.new(:even_r)

board[2, 1] = 'foo'
board[Hexagonal::Coordinate::Cube[0, 0]] = 'bar'
```

### Coordinates



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
