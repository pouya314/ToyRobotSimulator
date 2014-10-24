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
    
    def sit_on_table(table, x, y, f)
      raise InvalidCoordinatesException.new("Invalid Coordinates!") if not table.coordinates_valid?(x,y)
      raise WrongFacingDirectionException.new("Wrong Facing Direction Given for PLACE command.") if not facing_direction_valid?(f)
      
      @x = x
      @y = y
      @f = f
      @table = table
      "Robot Placed On Table Successfully"
    end
    
    
    def move
      
    end
    
    def turn_left
      
    end
    
    def turn_right
      
    end
    
    def announce_position
      {
        :x => @x,
        :y => @y,
        :f => @f
      }
    end
    
    protected
      def facing_direction_valid?(f)
        ALLOWED_FACING_DIRECTIONS.include?(f) ? true : false
      end
      
      def already_placed_on_table?
        @table == nil ? false : true
      end
  end
end