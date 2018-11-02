class Deck

  CARD_SUITS = {clubs: "\u2663", diamonds: "\u2666", hearts: "\u2665", spades: "\u2660"}
  CARD_VALUES = {"2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9,
                 "10" => 10, "J" => 10, "Q" => 10, "K" => 10, "A" => [10,1]}

  attr_reader :deck

  def initialize
    @deck = create_cards
  end

  def create_cards_by(suit_mark)
    CARD_VALUES.map { |value, points| value + suit_mark }
  end

  def create_cards
    deck = []
    CARD_SUITS.each do |name, mark|
      deck += create_cards_by(mark)
    end
    deck
  end

  def random_card(count)
    hand_out = []
    loop do 
      card_number = rand(deck.size)
      hand_out << deck[card_number]
      break(hand_out) if hand_out.size == count
    end
  end

  def card_value(card)
    CARD_VALUES[card[0]]
  end

  def reject_card(card)
    deck.delete(card)
  end

end