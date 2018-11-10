class Game
  A_BET = 10
  CARDS_COUNT_ON_START = 2
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

  def player
    @users.first
  end

  def dealer
    @users.last
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

    score_table = @score_raitings.sort_by { |user_data| -user_data[1] }
    @interface.score_raitings
    @interface.score_raitings_table(score_table)
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

  def show_users_balance
    users.each { |user| @interface.balance_info(@bank, user) }
  end

  def take_a_bet_from_users
    users.each { |user| @bank.reserve_money(user, A_BET) }
  end

  def show_users_hand(option)
    users.each { |user| @interface.show_hand(user, option) }
  end

  def change_users_score_by_cards
    users.each { |user| user.hand.change_score(user.hand.cards_score_in_hand) }
  end

  def create_users_account_in_bank
    users.each { |user| @bank.create_account(user) }
  end

  def give_users_cards
    users.each { |user| user.take_a_cards(@deck, CARDS_COUNT_ON_START) }
  end

  def reset_users_attribute
    users.each(&:reset_attributes)
  end

  def player_actions_menu(input)
    case input
    when 0
      nil
    when 1
      raise @interface.taking_card_error unless player.can_take_cards?

      player.take_a_cards(@deck, 1)
      @interface.show_hand(player, :only_player)
      player.hand.change_score(player.hand.cards_score_in_hand)
      @interface.devider(:light)
      @interface.show_user_score_by_cards(player)
      @interface.player_taked_card
      next_step_dealer
    when 2
      raise @interface.skip_action_error unless player.hand.skip_an_action?

      player.skip_an_action
      @interface.player_skiped_action
      next_step_dealer
    when 3
      @interface.show_all_cards
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

  def skip_an_action(user)
    raise "#{user.name} already skiped action" unless user.hand.skip_count.zero?

    user.up_skip_count
  end

  def show_all_cards
    show_users_hand(:all_users)
    @interface.devider(:strong)
    users.each { |user| @interface.show_user_score_by_cards(user) }
    define_the_winner
  end

  def show_game_status
    show_users_hand(:only_player)
    change_users_score_by_cards
    @interface.devider(:light)
    @interface.show_user_score_by_cards(@users.first)
  end

  def auto_show_card?
    return false unless dealer.can_take_cards? && player.can_take_cards?
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
    if dealer.can_take_cards?
      dealer.hand.take_a_cards(@deck, 1)
      @interface.dealer_taked_card
      next_step_player
    elsif dealer.hand.skip_an_action?
      dealer.skip_an_action
      @interface.dealer_skiped_action
      next_step_player
    else
      @interface.show_all_cards
      show_all_cards
    end
  end

  def define_the_winner
    @interface.round_end_screen
    winner = nil
    if player_is_winner?
      winner = player
    elsif dealer_is_winner?
      winner = dealer
    elsif draw?
      users.each do |user|
        @bank.unreserve_money(user, @bank.transactions[user].last.abs)
      end
      @interface.declare_the_dead_heat
      show_users_balance
    end
    if winner
      @bank.unreserve_money(winner, @bank.reserve)
      @interface.declare_the_victory_by(winner)
      show_users_balance
    end
  end

  def player_is_winner?
    !score_get_over?(player) && (score_get_over?(dealer) || player.hand.score > dealer.hand.score)
  end

  def dealer_is_winner?
    !score_get_over?(dealer) && (score_get_over?(player) || dealer.hand.score > player.hand.score)
  end

  def draw?
    player.hand.score == dealer.hand.score || (score_get_over?(player) && score_get_over?(dealer))
  end

  def score_get_over?(user)
    user.hand.score > SCORE_FOR_WIN
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
    @bank.balance(player).zero? || @bank.balance(dealer).zero?
  end

  def ask_next_round
    reset_users_attribute
    if next_round? && !users_balance_zero?
      @interface.starting_new_round
      start_a_round
    else
      @score_raitings << [player, @bank.balance(player)]
      @interface.game_over
    end
  end
end
