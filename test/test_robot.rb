require_relative '../lib/robogame/robot'
require_relative '../lib/robogame/table'

class TestRobot < MiniTest::Test
  def setup
    @r = Robogame::Robot.new
    @t = Robogame::Table.new(5,5)
  end
  
  def teardown
    @r = nil
  end
  
  def test_newly_created_robot_is_not_placed_on_the_table_automatically
    assert_nil @r.x
    assert_nil @r.y
    assert_nil @r.f
    assert_nil @r.table
  end
  
  def test_bad_placement_on_table
    assert_raises(InvalidCoordinatesException)   { @r.sit_on_table(@t, -1, 2, :NORTH) }
    assert_raises(InvalidCoordinatesException)   { @r.sit_on_table(@t, 5, -4, :NORTH) }
    assert_raises(InvalidCoordinatesException)   { @r.sit_on_table(@t, -3, -2, :NORTH) }
    assert_raises(WrongFacingDirectionException) { @r.sit_on_table(@t, 5, 4, :NORTHEAST) }
  end
  
  def test_good_placement_on_table
    assert_equal "ok", @r.sit_on_table(@t, 2, 3, :NORTH)
    assert_equal "ok", @r.sit_on_table(@t, 5, 0, :WEST)
  end
  
  def test_cannot_move_turn_or_announce_position_unless_placed_on_table
    assert_raises(RobotNotOnTableException) { @r.move }
    assert_raises(RobotNotOnTableException) { @r.turn_left }
    assert_raises(RobotNotOnTableException) { @r.turn_right }
    assert_raises(RobotNotOnTableException) { @r.announce_position }
  end
  
  def test_moving_off_table_boundries_should_not_be_allowed
    @r.sit_on_table(@t, 0, 0, :SOUTH)
    assert_raises(InvalidCoordinatesException) { @r.move }
  end
  
  def test_ok_move
    @r.sit_on_table(@t, 0, 0, :NORTH)
    assert_equal "ok", @r.move
  end
  
  def test_left_turn
    @r.sit_on_table(@t, 0, 0, :NORTH)
    @r.turn_left
    assert_equal :WEST, @r.f
    @r.turn_left
    assert_equal :SOUTH, @r.f
    @r.turn_left
    assert_equal :EAST, @r.f
    @r.turn_left
    assert_equal :NORTH, @r.f
  end
  
  def test_right_turn
    @r.sit_on_table(@t, 2, 3, :NORTH)
    @r.turn_right
    assert_equal :EAST, @r.f
    @r.turn_right
    assert_equal :SOUTH, @r.f
    @r.turn_right
    assert_equal :WEST, @r.f
    @r.turn_right
    assert_equal :NORTH, @r.f
  end
  
  def test_announce_position
    @r.sit_on_table(@t, 2, 3, :NORTH)
    pos = @r.announce_position
    assert_equal 2, pos[:x]
    assert_equal 3, pos[:y]
    assert_equal "NORTH", pos[:f].to_s
  end
end
