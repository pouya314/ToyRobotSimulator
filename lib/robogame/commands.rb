require_relative 'errors'
require_relative 'table'
require_relative 'robot'


module Robogame
  class Commands
    def initialize(table, robot)
      @table = table
      @robot = robot
    end
    
    def execute(command)
      raise EmptyCmd, "The command can not be empty!" if command.empty?

      (function, arguments) = command.split(' ',2)
      
      case function
      when "PLACE"
        if arguments.nil? || arguments.empty? || arguments.split(",").size != 3
          raise InvalidPlaceCmdArgs, "Invalid arguments given for PLACE command."
        end
        
        tokens = arguments.split(",")
        place(tokens[0].to_i, tokens[1].to_i, tokens[2].to_sym)
      when "MOVE"
        move
      when "LEFT"
        left
      when "RIGHT"
        right
      when "REPORT"
        report
      else
        raise InvalidCmd, "Invalid Command!"
      end
    end
    
    protected
      def place(x, y, f)
        @robot.sit_on_table(@table, x, y, f)
      end
    
      def move
        @robot.move
      end
    
      def left
        @robot.turn_left
      end
    
      def right
        @robot.turn_right
      end
    
      def report
        @robot.announce_position
      end
  end
end
