class EmptyCommandException < Exception
  attr :message
  def initialize(message)
    @message = message
  end
end