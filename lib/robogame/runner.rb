require_relative 'simulator'

module Robogame
  class Runner
    def run
      game = Game.new
      prompt = '> '
      puts prompt
      while user_input = gets.chomp.strip.upcase
        break if user_input == 'QUIT'
        begin
          output = game.play(user_input)
          puts output if output
        rescue Exception => e
          puts "Error: #{e.message}"
        end
        puts prompt
      end
    end
  end
end
