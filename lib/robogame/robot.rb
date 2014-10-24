require_relative 'wrong_facing_direction_exception'
require_relative 'invalid_coordinates_exception'

module Robogame
  class Robot
    attr_accessor :x, :y, :f, :table
    
    ALLOWED_FACING_DIRECTIONS = [:NORTH, :SOUTH, :EAST, :WEST]
    
    def initialize
      @x = nil
      @y = nil
      @f = nil
      @table = nil
    end
    
    def move
      
    end
    
    def turn_left
      
    end
    
    def turn_right
      
    end
    
    def get_position
      {
        :x => @x,
        :y => @y,
        :f => @f
      }
    end
  end
end