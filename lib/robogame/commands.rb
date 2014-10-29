require_relative 'table'
require_relative 'robot'
require_relative 'commands_validations'

module Robogame
  class Commands
    prepend CommandsValidations
    
    def initialize(table, robot)
      @table = table
      @robot = robot
    end
    
    def execute(func, *args)
      case func
      when "PLACE"
        (x,y,f) = *args
        @robot.sit_on_table(@table, x, y, f)
      when "MOVE"
        @robot.move
      when "LEFT"
        @robot.turn_left
      when "RIGHT"
        @robot.turn_right
      when "REPORT"
        @robot.announce_position
      end
    end
  end
end
