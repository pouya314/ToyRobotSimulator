module Robogame
  class Table
    def initialize(max_x, max_y)
      @min_x = 0
      @min_y = 0
      @max_x = max_x
      @max_y = max_y
    end
    
    def coordinates_valid?(x,y)
      x < @min_x || x > @max_x || y < @min_y || y > @max_y ? false : true
    end
  end
end
