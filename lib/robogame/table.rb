require_relative 'table_validations'

module Robogame
  class Table
    prepend TableValidations
    
    attr_accessor :min_x, :min_y, :max_x, :max_y
    
    def initialize(max_x, max_y)
      @min_x = 0
      @min_y = 0
      @max_x = max_x
      @max_y = max_y
    end
    
    def check_coordinates(x,y)
    end
  end
end
