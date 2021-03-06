# require 'minitest/autorun'
require_relative '../lib/robogame/table'

class TestTable < MiniTest::Test
  def setup
    @t = Robogame::Table.new(5,5)
  end

  def teardown
    @t = nil
  end

  def test_when_initialized_min_x_and_y_should_be_zero
    assert_equal 0, @t.min_x
    assert_equal 0, @t.min_y
  end

  def test_when_initialized_max_x_and_y_are_set_properly
    assert_equal 5, @t.max_x
    assert_equal 5, @t.max_y
  end

  def test_valid_coordinates_check_method_works
    assert_equal nil, @t.check_coordinates(0,0)
    assert_equal nil, @t.check_coordinates(3,4)
    assert_equal nil, @t.check_coordinates(2,5)
    assert_raises(InvalidCoordinates) {@t.check_coordinates(-2,-5)}
    assert_raises(InvalidCoordinates) {@t.check_coordinates(-2,55)}
    assert_raises(InvalidCoordinates) {@t.check_coordinates(112,-5)}
    assert_raises(InvalidCoordinates) {@t.check_coordinates(112,4405)}
  end
end
