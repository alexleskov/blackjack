class Card
  SUITS = { clubs: "\u2663", diamonds: "\u2666", hearts: "\u2665", spades: "\u2660" }.freeze
  VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
             '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => [11, 1] }.freeze

  attr_reader :suit, :face_value, :value

  def initialize(suit_name, face_value)
    @suit_name = suit_name.to_sym
    @face_value = face_value.to_s
    validate!
    @suit = SUITS[suit_name]
    @value = VALUES[face_value]
  end

  def validate!
    raise "Card's suit must be any value in Card::SUITS" unless SUITS.key?(@suit_name)
    raise "Card's face value must be any value in Card::VALUES" unless VALUES.key?(@face_value)
  end
end
