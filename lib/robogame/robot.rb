require_relative 'robot_validations'
require_relative 'config'
require_relative 'settings'

module Robogame
  class Robot
    prepend RobotValidations

    attr_accessor :x, :y, :f, :table
    
    def initialize
      @x     = nil
      @y     = nil
      @f     = nil
      @table = nil
    end
    
    def sit_on_table(table, x, y, f)
      @x     = x
      @y     = y
      @f     = f
      @table = table
      "ok"
    end
    
    def move(target_x, target_y)
      @x = target_x
      @y = target_y
      "ok"
    end
    
    def turn_left
      curr_index = ALLOWED_FACING_DIRECTIONS.index(@f)
      @f = (curr_index == 0 ? ALLOWED_FACING_DIRECTIONS[-1] : ALLOWED_FACING_DIRECTIONS[curr_index-1])
      "ok"
    end
    
    def turn_right
      curr_index = ALLOWED_FACING_DIRECTIONS.index(@f)
      @f = (curr_index == ALLOWED_FACING_DIRECTIONS.count-1 ? ALLOWED_FACING_DIRECTIONS[0] : ALLOWED_FACING_DIRECTIONS[curr_index+1])
      "ok"
    end
    
    def announce_position
      "#{@x},#{@y},#{@f}"
    end
  end
end