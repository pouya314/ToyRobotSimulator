require_relative 'table'
require_relative 'robot'

require_relative 'empty_command_exception'
require_relative 'invalid_command_exception'
require_relative 'wrong_number_of_arguments_for_place_exception'
require_relative 'wrong_facing_direction_exception'


module Robogame
  class Commands
    def initialize
      @table = Table.new(5,5)
      @robot = Robot.new
    end
    
    def execute(command)
      raise EmptyCommandException.new("The command you provided is empty!") if command.strip.empty?

      (function, arguments) = command.split(' ',2)
      
      case function
      when "PLACE"
        tokens = arguments.split(",")
        unless tokens.size == 3
          raise WrongNumberOfArgumentsForPlaceException.new("Wrong number of arguments given for PLACE command.")
        end
        unless [:NORTH, :SOUTH, :EAST, :WEST].include?(tokens.last.to_sym)
          raise WrongFacingDirectionException.new("Wrong Facing Direction Given for PLACE command.")
        end
        
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
        raise InvalidCommandException.new("The command you provided is invalid!")
      end
    end
    
    def place(x, y, f)
      
    end
    
    def move
      
    end
    
    def left
      
    end
    
    def right
      
    end
    
    def report
      
    end
  end
end
