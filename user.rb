class User
  class << self
    attr_reader :all
  end

  @all = {}

  def self.find(user_name)
    all[user_name]
  end

  attr_reader :name, :balance, :cards_in_hand, :score, :skip_count

  def initialize(name)
    @name = name
    @balance = 0
    @cards_in_hand = []
    @score = 0
    @skip_count = 0
    self.class.all[name] = self
  end

  def change_balance(value)
    raise 'Value less or equial zero' if value < 0

    @balance = value
  end

  def change_score(value)
    raise 'Value less or equial zero' if value <= 0

    @score = value
  end

  def up_skip_count
    @skip_count += 1
  end

  def take_in_hand(card)
    raise 'Card\\Cards Must be Array class' unless card.is_a?(Array)

    @cards_in_hand += card
  end

  def reset_attributes
    @skip_count = 0
    @score = 0
    @cards_in_hand = []
  end
end
