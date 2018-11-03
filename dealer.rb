class Dealer < User

  class << self
    attr_reader :all
  end

  @all = {}
   
  def initialize
    super("Dealer")
  end
end