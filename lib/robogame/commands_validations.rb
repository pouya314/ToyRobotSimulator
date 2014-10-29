require_relative 'errors'
require_relative 'config'

module CommandsValidations
  def execute(command)
    raise EmptyCmd, "The command can not be empty!" if command.empty?
    
    (function, arguments) = command.split(' ',2)
    raise InvalidCmd, "Invalid Command!" unless VALID_FUNCTIONS.include? function
    
    if function == "PLACE"
      if arguments.nil? || arguments.empty? || arguments.gsub(/\s+/, "").split(",").size != 3
        raise WrongNoOfArgs, "Wrong number of arguments for PLACE command!"
      end
      tokens = arguments.gsub(/\s+/, "").split(",")
      super(function, tokens[0], tokens[1], tokens[2])
    else
      raise WrongNoOfArgs, "Unexpected Arguments!" unless arguments.nil?
      super(function)
    end
  end
end