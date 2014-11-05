require_relative 'generic_parser_validations'
require_relative 'place_parser_validations'
require_relative 'single_word_command_validations'
require_relative 'table'
require_relative 'robot'
require_relative 'settings'


module Robogame

  @@robot
  def self.setRobot(r) @@robot = r end
  def self.getRobot; @@robot end

  @@table
  def self.setTable(t) @@table = t end
  def self.getTable; @@table end


  ################################# PARSERS ####################################
  class SingleWordCommandParser
    prepend SingleWordCommandParserValidations

    def parse(arguments); end
  end

  class REPORTParser < SingleWordCommandParser
    def parse(arguments)
      super; Robogame::getRobot.announce_position
    end
  end

  class RIGHTParser < SingleWordCommandParser
    def parse(arguments)
      super; Robogame::getRobot.turn_right
    end
  end

  class LEFTParser < SingleWordCommandParser
    def parse(arguments)
      super; Robogame::getRobot.turn_left
    end
  end

  class MOVEParser < SingleWordCommandParser
    def parse(arguments)
      super; Robogame::getRobot.move
    end
  end

  class PLACEParser
    prepend PlaceParserValidations

    def parse(x, y, f)
      Robogame::getRobot.sit_on_table(Robogame::getTable, x, y, f)
    end
  end

  class GenericParser
    prepend GenericParserValidations

    def parse(function, arguments)
      Object.const_get("Robogame::#{function}Parser").new.parse(arguments)
    end
  end
  ##############################################################################


  class Game
    def initialize
      # Create main components/objects/players of the game:
      # - Table
      # - Robot
      # - Parser
      Robogame::setTable Table.new(TABLE_MAX_X, TABLE_MAX_Y)
      Robogame::setRobot Robot.new
      @generic_parser = GenericParser.new
    end

    def play(command)
      @generic_parser.parse(command)
    end
  end
end
