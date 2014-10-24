require_relative "commands"

module Robogame
  class Runner
    def run
      command_centre = Commands.new
      prompt = '> '
      puts prompt
      while command = gets.chomp.strip.upcase
        break if command == 'QUIT'
        begin
          command_centre.execute(command)
        rescue Exception => e
          puts "#{e.class}: #{e.message}"
        end
        puts prompt
      end
    end
  end
end