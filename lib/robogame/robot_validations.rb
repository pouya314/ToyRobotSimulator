require_relative 'errors'
require_relative 'settings'

module RobotValidations
  def robot_should_be_on_table_already
    raise RobotNotPlaced, "Robot not placed on the table yet!" if @table == nil
  end

  def is_integer?(s)
    /\A[-+]?\d+\z/ === s
  end

  def sit_on_table(table, x, y, f)
    raise CoordinatesNotInteger, "Coordinates for PLACE command must be of type Integer." unless is_integer?(x) && is_integer?(y)
    table.check_coordinates(x.to_i, y.to_i)
    raise InvalidRobotDirection, "Wrong Facing Direction Given for PLACE command." unless ALLOWED_FACING_DIRECTIONS.include?(f.to_sym)
    super(table, x.to_i, y.to_i, f.to_sym)
  end

  def move
    robot_should_be_on_table_already

    case @f
    when :NORTH
        # move_to(@x,@y+1)
        target_x = @x
        target_y = @y+1
    when :SOUTH
        # move_to(@x,@y-1)
        target_x = @x
        target_y = @y-1
    when :WEST
        # move_to(@x-1,@y)
        target_x = @x-1
        target_y = @y
    when :EAST
        # move_to(@x+1,@y)
        target_x = @x+1
        target_y = @y
    end

    @table.check_coordinates(target_x,target_y)

    super(target_x, target_y)
  end

  def turn_left
    robot_should_be_on_table_already
    super
  end

  def turn_right
    robot_should_be_on_table_already
    super
  end

  def announce_position
    robot_should_be_on_table_already
    super
  end
end
