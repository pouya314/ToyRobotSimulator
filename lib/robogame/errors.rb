class GameException < Exception; end

# Command errors
class EmptyCmd < GameException; end
class InvalidCmd < GameException; end
class WrongNoOfArgs < GameException; end

# Robot Errors
class InvalidRobotDirection < GameException; end
class RobotNotPlaced < GameException; end
class CoordinatesNotInteger < GameException; end

# Table Errors
class InvalidCoordinates < GameException; end
