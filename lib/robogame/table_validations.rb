require_relative 'errors'

module  TableValidations
  def check_coordinates(x,y)
    raise InvalidCoordinates, "Invalid Coordinates!" if x < @min_x || x > @max_x || y < @min_y || y > @max_y
    super
  end
end