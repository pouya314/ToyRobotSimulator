require_relative '../lib/robogame/commands'

class TestCommands < MiniTest::Test  
  def setup
    @cc = Robogame::Commands.new
  end
  
  def teardown
    @cc = nil
  end
  
  def test_handle_empty_command
    assert_raises(EmptyCommandException) { @cc.execute("") }
  end
  
  def test_invalid_command
    ["FLY", "WALK 0,0,NORTH", "SING", "DO 1,1,WEST", "RIGH", "LEF", "MOOVE", "REPOT"].each do |invalid_cmd|
      assert_raises(InvalidCommandException) { @cc.execute(invalid_cmd) }
    end
  end
  
  def test_place_command_with_bad_arguments
    ["PLACE", "PLACE ", "PLACE 0,0", "PLACE 1,1,1,1,NORTH", "PLACE 0"].each do |bad_arg|
      assert_raises(WrongNumberOfArgumentsForPlaceException) { @cc.execute(bad_arg) }
    end
  end
  
  def test_place_command_with_out_of_boundry_coordinates
    ["PLACE -1,3,NORTH", "PLACE 4,-5,WEST", "PLACE -5,-1,EAST"].each do |cmd|
      assert_raises(InvalidCoordinatesException) { @cc.execute(cmd) }
    end
  end
  
  def test_place_command_with_wrong_facing_direction_value
    ["PLACE 0,1,SOUTHWEST", "PLACE 0,0,NORTH-EAST", "PLACE 4,5,WOOT"].each do |cmd|
      assert_raises(WrongFacingDirectionException) { @cc.execute(cmd) }
    end
  end
  
  def test_valid_place_command_returns_ok
    ["PLACE 0,0,NORTH", "PLACE 1,0,WEST", "PLACE 3,4,SOUTH"].each do |good_place_cmd|
      assert_equal "ok", @cc.execute(good_place_cmd)
    end
  end
  
  def test_all_other_commands_are_properly_delegated
    @cc.execute("PLACE 0,0,NORTH")
    assert_equal "ok", @cc.execute("MOVE")
    assert_equal "ok", @cc.execute("LEFT")
    assert_equal "ok", @cc.execute("RIGHT")
    assert_equal "0,1,NORTH", @cc.execute("REPORT")
  end
  
  def test_no_command_can_be_executed_before_robot_is_placed_on_table
    ["MOVE", "LEFT", "RIGHT", "REPORT"].each do |cmd|
      assert_raises(RobotNotOnTableException) { @cc.execute(cmd) }
    end
    
    # now we place the robot on the table, and try again:
    @cc.execute("PLACE 1,1,WEST")
    
    ["LEFT", "RIGHT", "MOVE"].each do |cmd|
      assert_equal "ok", @cc.execute(cmd)
    end
    assert_equal "0,1,WEST", @cc.execute("REPORT")
  end
  
  def test_moving_out_of_boundry_should_not_be_allowed
    @cc.execute("PLACE 0,0,WEST")
    assert_raises(InvalidCoordinatesException) { @cc.execute("MOVE") }
  end
end
