class Hand
  MAX_CARDS_COUNT = 3

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
    cards.each do |card|
      card_value = if card.face_value == 'A' && (cards_score > 10 || @score > 10)
                     card.value[1]
                   elsif card.face_value == 'A'
                     card.value[0]
                   else
                     card.value
                   end
      cards_score += card_value
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
