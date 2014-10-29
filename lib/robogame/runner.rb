require_relative "config"
require_relative "commands"
require_relative "table"
require_relative "robot"

module Robogame
  class Runner
    def run
      command_centre = Commands.new(Table.new(TABLE_MAX_X, TABLE_MAX_Y), Robot.new)
      prompt = '> '
      puts prompt
      while command = gets.chomp.strip.upcase
        break if command == 'QUIT'
        begin
          res = command_centre.execute(command)
          puts res if res
        rescue Exception => e
          puts "Error: #{e.message}"
        end
        puts prompt
      end
    end
  end
end