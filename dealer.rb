require_relative 'validation.rb'

class Dealer < User
  include Validation

  DEALER_SCORE_SETTING = 17

  validate :name, :type, String

  def initialize
    super('Dealer')
  end

  def skip_an_action
    return false if score < DEALER_SCORE_SETTING
    
    super
    true
  end

  def take_a_cards(deck, count)
    return false if score >= DEALER_SCORE_SETTING
    
    super
    true
  end

  def show_cards
    return false if skip_an_action == true || take_a_cards == true

    super
    true
  end

end
