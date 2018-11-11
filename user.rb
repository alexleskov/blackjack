class User
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = Hand.new(self)
  end

  def reset_attributes
    @hand = Hand.new(self)
  end

  def skip_an_action
    @hand.skip_an_action
  end

  def take_a_cards(deck, count)
    @hand.take_a_cards(deck, count)
  end

  def can_take_cards?
    @hand.can_take_cards?
  end
end
