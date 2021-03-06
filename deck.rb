class Deck
  attr_reader :cards

  def initialize
    @cards = initialize_cards
  end

  def initialize_cards
    cards = []
    Card::SUITS.each do |suit_name, _mark|
      Card::VALUES.each do |face_value, _value|
        cards << Card.new(suit_name, face_value)
      end
    end
    cards.shuffle!
  end

  def reject_card_by_index(index)
    raise "No such card in deck" if index < 0 && index > cards.size

    cards.delete(cards[index])
  end

  def give_cards(count)
    raise 'Card count for giving less or equial zero' if count <= 0
    raise "Card count for giving is so much then deck size" if cards.size < count

    hand = []
    cards_index = (0..count - 1)
    cards_index.each do |index|
      hand << @cards[index]
      reject_card_by_index(index)
    end
    hand
  end

  def find(suit, face_value)
    index = cards.index { |card| card.suit == suit && card.face_value == face_value }
    return if index.nil?

    cards[index]
  end
end
