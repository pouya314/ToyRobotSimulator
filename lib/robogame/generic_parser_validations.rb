require_relative 'errors'
require_relative 'settings'

module GenericParserValidations
  def parse(command)
    raise EmptyCmd, "The command can not be empty!" if command.empty?
    (function, arguments) = command.split(' ',2)
    raise InvalidCmd, "Invalid Command!" unless VALID_FUNCTIONS.include? function
    super(function, arguments)
  end
end
