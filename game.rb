class Game

  attr_reader :users, :bank

  def initialize
    @users = []
    @score_raiting = []
    @interface = Interface.new
    @bank = Bank.new
    @deck = Deck.new
  end

  def menu
    loop do
      @interface.main_menu
      input = choice
      abort if input.zero?
      menu_cases(input)
    end
  end

  private

  def choice
    @interface.ask_choice
  end

  def menu_cases(input)
    case input
    when 0
      abort
    when 1
      start_the_game
    else
      @interface.incorrect_choice
    end
  end

  def start_the_game
    player = User.new(@interface.ask_player_name)
    dealer = Dealer.new
    @users += [player, dealer]
    users.each { |user| @bank.create_account(user) }
    @interface.starting
    users.each { |user| @interface.balance_info(user) }
    users.each { |user| user.take_in_hand(@deck.random_card(2)) }
    users.each { |user| @interface.show_hand(user) }
  end

end
