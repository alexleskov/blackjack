class Deck
  CARD_SUITS = { clubs: "\u2663", diamonds: "\u2666", hearts: "\u2665", spades: "\u2660" }.freeze
  CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
                  '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => [11, 1] }.freeze

  attr_reader :deck

  def initialize
    @deck = create_cards
  end

  def card_value(card)
    CARD_VALUES[card.chop]
  end

  def random_card(count)
    raise 'Deck is clear. Not enouht cards' if @deck.empty?

    cards = []
    count.times do
      card = deck[rand(deck.size)]
      cards << card
      reject_card(card)
    end
    cards
  end

  def create_cards_by(suit_mark)
    CARD_VALUES.map { |value, _points| value + suit_mark }
  end

  def create_cards
    deck = []
    CARD_SUITS.each do |_name, mark|
      deck += create_cards_by(mark)
    end
    deck
  end

  def reject_card(card)
    deck.delete(card)
  end
end
