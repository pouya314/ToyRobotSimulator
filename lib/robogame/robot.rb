require_relative 'wrong_facing_direction_exception'
require_relative 'invalid_coordinates_exception'
require_relative 'robot_not_on_table_exception'

module Robogame
  class Robot
    attr_accessor :x, :y, :f, :table
    
    ALLOWED_FACING_DIRECTIONS = [:NORTH, :EAST, :SOUTH, :WEST]
    
    def initialize
      @x = nil
      @y = nil
      @f = nil
      @table = nil
    end
    
    def sit_on_table(table, x, y, f)
      raise InvalidCoordinatesException.new("Invalid Coordinates!") unless table.coordinates_valid?(x,y)
      raise WrongFacingDirectionException.new("Wrong Facing Direction Given for PLACE command.") unless facing_direction_valid?(f)
      
      @x = x
      @y = y
      @f = f
      @table = table
      "Robot Placed On Table Successfully"
    end
    
    
    def move
      raise RobotNotOnTableException.new("Robot not placed on the table yet!") unless already_placed_on_table?
      
      case @f
      when :NORTH
          move_to(@x,@y+1)
      when :SOUTH
          move_to(@x,@y-1)
      when :WEST
          move_to(@x-1,@y)
      when :EAST
          move_to(@x+1,@y)
      end
    end
    
    def turn_left
      raise RobotNotOnTableException.new("Robot not placed on the table yet!") unless already_placed_on_table?
      curr_index = ALLOWED_FACING_DIRECTIONS.index(@f)
      @f = (curr_index == 0 ? ALLOWED_FACING_DIRECTIONS[-1] : ALLOWED_FACING_DIRECTIONS[curr_index-1])
    end
    
    def turn_right
      raise RobotNotOnTableException.new("Robot not placed on the table yet!") unless already_placed_on_table?
      
    end
    
    def announce_position
      raise RobotNotOnTableException.new("Robot not placed on the table yet!") unless already_placed_on_table?

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
      
      def move_to(target_x, target_y)
        raise InvalidCoordinatesException.new("Out of Boundry movement is not allowed!") unless @table.coordinates_valid?(target_x,target_y)
        
        @x = target_x
        @y = target_y
      end
  end
end