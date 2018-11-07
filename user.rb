require_relative 'validation.rb'

class User
  include Validation

  MAX_CARDS_COUNT = 3

  attr_reader :name, :hand, :score, :skip_count
  alias_method :show_cards, :hand

  validate :name, :presence
  validate :name, :type, String

  def initialize(name)
    @name = name
    validate!
    @hand = []
    @score = 0
    @skip_count = 0
  end

  def change_score(value)
    raise 'Value less or equial zero' if value <= 0

    @score = value
  end

  def skip_an_action
    return false unless skip_count.zero?

    @skip_count += 1
  end

  def take_a_cards(deck, count)
    cards = deck.give_cards(count)

    return false if hand.size > MAX_CARDS_COUNT || cards.size > MAX_CARDS_COUNT - hand.size

    @hand += cards
  end

  def reset_attributes
    @skip_count = 0
    @score = 0
    @hand = []
  end
end
