class Dealer < User
  DEALER_SCORE_SETTING = 17

  def initialize
    super('Dealer')
  end

  def skip_an_action
    return false unless settings_limit_reached?

    super
  end

  def take_a_cards(deck, count)
    return false if settings_limit_reached?

    super
  end

  def show_cards
    return false if @hand.skip_an_action? || !can_take_cards?

    super
  end

  def can_take_cards?
    return false if settings_limit_reached?

    super
  end

  def settings_limit_reached?
    @hand.score >= DEALER_SCORE_SETTING
  end
end
