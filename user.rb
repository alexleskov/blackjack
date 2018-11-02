class User

  MAX_CARDS_COUNT = 3

  attr_reader :name, :balance, :cards_in_hand, :score

  def initialize(name)
    @name = name
    @balance = 0
    @cards_in_hand = []
    @score = 0
  end

  def change_balance(value)
    raise "Value less or equial zero" if value <= 0

    @balance = value
  end

  def change_score(value)
    raise "Value less or equial zero" if value <= 0

    if score >= value
      @score -= value
    else
      @score = 0
    end
  end

  def take_in_hand(card)
    raise "User already have got #{MAX_CARDS_COUNT} cards" if cards_in_hand.size > MAX_CARDS_COUNT
    raise "Card\\Cards Must be Array class" unless card.is_a?(Array)

    @cards_in_hand += card
  end


end