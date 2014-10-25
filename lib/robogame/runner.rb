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
          res = command_centre.execute(command)
          puts res if res
        rescue Exception => e
          puts "#{e.class}: #{e.message}"
        end
        puts prompt
      end
    end
  end
end