class Card
  CARD_SUITS = { clubs: "\u2663", diamonds: "\u2666", hearts: "\u2665", spades: "\u2660" }.freeze
  CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
                  '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => [11, 1] }.freeze

  def self.suits
    CARD_SUITS
  end

  def self.face_values
    CARD_VALUES
  end

  attr_reader :suit, :face_value, :value

  def initialize(suit_name, face_value)
    suit_name = suit_name.to_sym
    @face_value = face_value.to_s

    unless CARD_SUITS.key?(suit_name) && CARD_VALUES.key?(face_value)
      raise "Can't creat card with params: #{suit_name}, #{face_value}"
    end

    @suit = CARD_SUITS[suit_name]
    @value = CARD_VALUES[face_value]
  end
end
