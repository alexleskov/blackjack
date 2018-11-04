class Game
  A_BET = 10
  CARDS_COUNT_ON_START = 2
  MAX_CARDS_COUNT = 3
  DEALER_SCORE_SETTING = 17
  SCORE_FOR_WIN = 21

  attr_reader :users, :bank

  def initialize
    @users = []
    @score_raitings = []
    @interface = Interface.new
    @bank = Bank.new
  end

  def menu
    loop do
      @interface.main_menu
      input = choice
      return if input.zero?

      menu_cases(input)
    end
  rescue StandardError => e
    @interface.show_error(e)
    retry
  end

  private

  def choice
    @interface.ask_choice
  end

  def menu_cases(input)
    case input
    when 1
      start_the_game
    when 2
      show_score_raitings
    else
      raise @interface.incorrect_choice
    end
  end

  def start_the_game
    player = User.new(@interface.ask_player_name)
    dealer = Dealer.new
    @users = [player, dealer]
    create_users_account_in_bank
    start_a_round
  end

  def show_score_raitings
    return @interface.empty_list if @score_raitings.empty?

    score_table = @score_raitings.sort_by { |user| -user.balance }
    @interface.score_raitings
    score_table.each { |user| @interface.score_raitings_table(user, score_table) }
  end

  def start_a_round
    @interface.start_screen
    @deck = Deck.new
    give_users_cards
    show_users_balance
    @interface.taking_a_bet
    take_a_bet_from_users
    show_users_balance
    @interface.getting_on_a_cards
    show_game_status
    ask_player_for_actions
    ask_next_round
  rescue RuntimeError => e
    @interface.show_error(e)
    retry
  end

  def do_action_with_users(block)
    users.each { |user| block.call(user) }
  end

  def show_users_balance
    do_action_with_users ->(user) { @interface.balance_info(user) }
  end

  def take_a_bet_from_users
    do_action_with_users ->(user) { @bank.reserve_money(user, A_BET) }
  end

  def show_users_hand(option)
    do_action_with_users ->(user) { @interface.show_hand(user, option) }
  end

  def change_users_score_by_cards
    do_action_with_users ->(user) { user.change_score(cards_score_in_hand(user)) }
  end

  def create_users_account_in_bank
    do_action_with_users ->(user) { @bank.create_account(user) }
  end

  def give_users_cards
    do_action_with_users ->(user) { give_a_cards(user, CARDS_COUNT_ON_START) }
  end

  def reset_users_attribute
    do_action_with_users ->(user) { user.reset_attributes }
  end

  def give_a_cards(user, count)
    raise "User already have got #{MAX_CARDS_COUNT} cards" if user.cards_in_hand.size > MAX_CARDS_COUNT

    cards = @deck.random_card(count)

    raise 'So much cards are trying to give user' if cards.size > MAX_CARDS_COUNT - user.cards_in_hand.size

    user.take_in_hand(cards)
  end

  def cards_score_in_hand(user)
    cards_score = 0
    user.cards_in_hand.each do |card|
      card_value = if card.chop == 'A' && cards_score > 10
                     @deck.card_value(card)[1]
                   elsif card.chop == 'A'
                     @deck.card_value(card)[0]
                   else
                     @deck.card_value(card)
                   end
      cards_score += card_value
    end
    cards_score
  end

  def player_actions_menu(input)
    player = @users.first
    case input
    when 1
      give_one_more_card(player)
      @interface.show_hand(player, :only_player)
      player.change_score(cards_score_in_hand(player))
      @interface.devider(:light)
      @interface.show_user_score_by_cards(player)
      next_step_dealer
    when 2
      skip_an_action(player)
      @interface.dealer_actions
      dealer_actions
    when 3
      show_all_cards
    else
      raise @interface.incorrect_choice
    end
  end

  def ask_player_for_actions
    @interface.player_actions_menu
    input = choice
    player_actions_menu(input)
  rescue RuntimeError => e
    @interface.show_error(e)
    retry
  end

  def give_one_more_card(user)
    give_a_cards(user, 1)
  end

  def skip_an_action(user)
    raise "#{user.name} already skiped action" unless user.skip_count.zero?

    user.up_skip_count
  end

  def show_all_cards
    show_users_hand(:all_users)
    @interface.devider(:strong)
    do_action_with_users ->(user) { @interface.show_user_score_by_cards(user) }
    define_the_winner
  end

  def show_game_status
    show_users_hand(:only_player)
    change_users_score_by_cards
    @interface.devider(:light)
    @interface.show_user_score_by_cards(@users.first)
  end

  def auto_show_card?
    player = @users.first
    dealer = @users.last
    dealer.cards_in_hand.size == MAX_CARDS_COUNT && player.cards_in_hand.size == MAX_CARDS_COUNT
  end

  def next_step_player
    if auto_show_card?
      show_all_cards
    else
      show_game_status
      ask_player_for_actions
    end
  end

  def next_step_dealer
    if auto_show_card?
      show_all_cards
    else
      @interface.dealer_actions
      dealer_actions
    end
  end

  def dealer_actions
    dealer = @users.last
    dealer_score = dealer.score
    if dealer_score >= DEALER_SCORE_SETTING && dealer.skip_count.zero?
      skip_an_action(dealer)
      @interface.dealer_skiped_action
      show_game_status
      ask_player_for_actions
    elsif dealer_score < DEALER_SCORE_SETTING && dealer.cards_in_hand.size != MAX_CARDS_COUNT
      give_one_more_card(dealer)
      dealer.change_score(cards_score_in_hand(dealer))
      @interface.dealer_taked_card
      next_step_player
    else
      show_all_cards
    end
  end

  def define_the_winner
    player = @users.first
    dealer = @users.last
    @interface.round_end_screen
    winner = nil
    if player_is_winner?(player, dealer)
      winner = player
    elsif dealer_is_winner?(player, dealer)
      winner = dealer
    elsif draw?(player, dealer)
      do_action_with_users(lambda do |user|
        @bank.unreserve_money(user, @bank.all_transactions_by(user).last.values[0].abs)
      end)
      @interface.declare_the_dead_heat
      show_users_balance
    end
    unless winner.nil?
      @bank.unreserve_money(winner, @bank.reserve)
      @interface.declare_the_victory_by(winner)
      show_users_balance
    end
  end

  def player_is_winner?(player, dealer)
    player.score <= SCORE_FOR_WIN && (dealer.score > SCORE_FOR_WIN || player.score > dealer.score)
  end

  def dealer_is_winner?(player, dealer)
    dealer.score <= SCORE_FOR_WIN && (player.score > SCORE_FOR_WIN || dealer.score > player.score)
  end

  def draw?(player, dealer)
    player.score == dealer.score || (player.score > SCORE_FOR_WIN && dealer.score > SCORE_FOR_WIN)
  end

  def next_round?
    @interface.ask_next_round
    input = choice
    case input
    when 1
      true
    when 2
      false
    else
      raise @interface.incorrect_choice
    end
  rescue RuntimeError => e
    @interface.show_error(e)
    retry
  end

  def users_balance_zero?
    @users.first.balance.zero? || @users.last.balance.zero?
  end

  def ask_next_round
    player = @users.first
    reset_users_attribute
    if next_round? && !users_balance_zero?
      @interface.starting_new_round
      start_a_round
    else
      @score_raitings << player
      @interface.game_over
    end
  end
end
