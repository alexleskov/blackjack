class User

  attr_reader :name, :cards_in_hand, :score
  attr_accessor :deposite

  def initialize(name)
    @name = name
    @deposite = 0
    @cards_in_hand = []
    @score = 0
  end

  def pay_money(value)
    raise "Value must be >= then 0" if value < 0
    @deposite -= value
  end

  def take_money(value)
    raise "Value must be >= then 0" if value < 0
    @deposite += value
  end

end