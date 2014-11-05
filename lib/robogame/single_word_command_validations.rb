require_relative 'errors'

module SingleWordCommandParserValidations
  def parse(arguments)
    raise WrongNoOfArgs, "Unexpected Arguments!" unless arguments.nil?
    super(arguments)
  end
end
