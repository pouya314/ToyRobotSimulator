require_relative 'errors'

module PlaceParserValidations
  def parse(arguments)
    if arguments.nil? || arguments.empty? || arguments.gsub(/\s+/, "").split(",").size != 3
      raise WrongNoOfArgs, "Wrong number of arguments for PLACE command!"
    end
    tokens = arguments.gsub(/\s+/, "").split(",")
    super(tokens[0], tokens[1], tokens[2])
  end
end
