require_relative 'errors'

module Robogame
  class Table
    
    attr_accessor :min_x, :min_y, :max_x, :max_y
    
    def initialize(max_x, max_y)
      @min_x = 0
      @min_y = 0
      @max_x = max_x
      @max_y = max_y
    end
    
    def check_coordinates(x,y)
      raise InvalidCoordinates, "Invalid Coordinates!" if x < @min_x || x > @max_x || y < @min_y || y > @max_y
    end
  end
end
