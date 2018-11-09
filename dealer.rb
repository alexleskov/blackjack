class Dealer < User
  DEALER_SCORE_SETTING = 17

  def initialize
    super('Dealer')
  end

  def skip_an_action
    return false if score < DEALER_SCORE_SETTING

    super
  end

  def take_a_cards(deck, count)
    return false if score >= DEALER_SCORE_SETTING

    super
  end

  def show_cards
    return false if skip_an_action? || !can_take_cards?

    super
  end

  def can_take_cards?
    return false if score >= DEALER_SCORE_SETTING

    super
  end
end
