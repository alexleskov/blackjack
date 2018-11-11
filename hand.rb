class Hand
  MAX_CARDS_COUNT = 3
  SCORE_FOR_WIN = 21
  CROSS_VALUE = 10
  ACE_COUNT_SETTING = 2

  attr_reader :cards, :score, :skip_count

  def initialize(user)
    @user = user
    validate!
    @cards = []
    @score = 0
    @skip_count = 0
  end

  def validate!
    raise "User must be object by class User" unless @user.is_a?(User)
  end

  def change_score(value)
    raise 'Value less or equial zero' if value <= 0

    @score = value
  end

  def cards_score_in_hand
    cards_score = 0
    x_cards = []

    cards.each do |card|
      if card.face_value == 'A'
        x_cards << card.value
      else
        cards_score += card.value
      end
    end

    unless x_cards.empty?
      x_cards_count = x_cards.size
      x_cards.each do |x_card_value|
        if cards_score <= CROSS_VALUE && x_cards_count < ACE_COUNT_SETTING
          cards_score += x_card_value[0]
        else
          cards_score += x_card_value[1]
          x_cards_count -= 1
        end
      end
    end
    cards_score
  end

  def skip_an_action
    return unless skip_count.zero?

    @skip_count += 1
  end

  def take_a_cards(deck, count)
    giving_cards = deck.give_cards(count)

    return if cards.size > MAX_CARDS_COUNT || giving_cards.size > MAX_CARDS_COUNT - cards.size

    @cards += giving_cards
  end

  def skip_an_action?
    !!skip_an_action
  end

  def can_take_cards?
    return if cards.size == MAX_CARDS_COUNT

    true
  end
end
