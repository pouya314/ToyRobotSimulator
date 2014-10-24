require_relative 'table'
require_relative 'robot'
require_relative 'empty_command_exception'
require_relative 'invalid_command_exception'


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
        place(arguments)
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
  end
end
