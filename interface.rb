class Interface
  def main_menu
    puts "\n----------------------------------------------"
    puts "\u2663 \u2666 \u2665 \u2660  WELCOME TO \"BlackJack\" GAME! \u2663 \u2666 \u2665 \u2660"
    puts '----------------------------------------------'
    puts "        | Press '1' - Start a game   |        "
    puts "        | Press '2' - Score raitings |        "
    puts "        | Press '0' - Exit           |        "
    puts '----------------------------------------------'
  end

  def start_screen
    puts "\n\u2663 \u2666 \u2665 \u2660  THE GAME IS STARTING \u2663 \u2666 \u2665 \u2660"
    puts "--------------------------------------\n"
  end

  def ask_choice
    loop do
      puts "\nPress a number of menu ('0' - back/quit):"
      puts "-----------------------------------\n"
      input = gets.chomp
      break(input.to_i) unless input.empty?
    end
  end

  def incorrect_choice
    "\n[Menu variant like that doesn't exist]\n"
  end

  def ask_player_name
    loop do
      puts "\nEnter your name: "
      player_name = gets.chomp
      break(player_name) unless player_name.empty?
    end
  end

  def balance_info(bank, user)
    print "| #{user.name}'s balance is #{bank.balance(user)}$ "
    print '|'
  end

  def show_hand(user, option)
    print "\n#{user.name} cards: |"
    user.hand.each do |card|
      if user.instance_of?(User) || option == :all_users
        print "#{card.face_value}#{card.suit}|"
      else
        print '*|'
      end
    end
  end

  def taking_a_bet
    puts "\n\n###################################"
    puts ' Each player is giving a bet - 10$  '
    puts "###################################\n\n"
  end

  def getting_on_a_cards
    puts "\n\n##################################"
    puts '   Players are getting on cards       '
    puts '##################################'
  end

  def devider(option)
    if option == :light
      puts "\n---------------------------------\n"
    elsif option == :strong
      puts "\n##################################\n"
    end
  end

  def show_user_score_by_cards(user)
    puts "#{user.name} your score by cards is: #{user.score}\n"
  end

  def player_actions_menu
    puts "\nChoose a variant of action:"
    puts '--------------------------'
    puts "\n1 - Take one more card\n2 - Skip\n3 - Show all cards"
  end

  def dealer_actions
    puts "\n\n######################################"
    puts '      Dealer is doing his choise      '
    puts '######################################'
  end

  def dealer_skiped_action
    puts "\n*Dealer skiped action"
    puts 'Now is YOUR turn'
  end

  def player_skiped_action
    puts "\n*You skiped action"
    puts 'Now is DEALER turn'
  end

  def dealer_taked_card
    puts "\n*Dealer taked one more card"
    puts 'Now is YOUR turn'
  end

  def player_taked_card
    puts "\n*You taked one more card"
    puts 'Now is DEALER turn'
  end

  def show_all_cards
    puts "\n*SHOWING ALL CARDS"
  end

  def round_end_screen
    puts "\n\u2663 \u2666 \u2665 \u2660  THE ROUND IS OVER \u2663 \u2666 \u2665 \u2660"
    puts "----------------------------------\n"
    puts '                RESULTS              '
    puts "----------------------------------\n"
  end

  def declare_the_victory_by(user)
    congratilation = "HOLY SON OF LUCKY!!! THE WINNER IS - #{user.name.upcase}"
    puts "\n"
    congratilation.length.times { print '$' }
    puts "\n\n#{congratilation}\n\n"
    congratilation.length.times { print '$' }
    puts "\n\n"
  end

  def declare_the_dead_heat
    congratilation = 'DRAW: THERE IS NO THE ONE WINNER'
    puts "\n"
    congratilation.length.times { print '@' }
    puts "\n\n#{congratilation}\n\n"
    congratilation.length.times { print '@' }
    puts "\n\n"
  end

  def ask_next_round
    puts "\n\n\u2663 \u2666 \u2665 \u2660  NEXT ROUND? \u2663 \u2666 \u2665 \u2660"
    puts "\n1 - NEXT ROUND\n2 - GAME OVER"
  end

  def starting_new_round
    puts "\n[A new round is starting]\n"
  end

  def game_over
    puts "\n\n\u2663 \u2666 \u2665 \u2660  THE GAME IS OVER \u2663 \u2666 \u2665 \u2660"
  end

  def score_raitings
    puts "\n\n\u2663 \u2666 \u2665 \u2660  SCORE RAITINGS \u2663 \u2666 \u2665 \u2660"
    puts "----------------------------------\n"
  end

  def score_raitings_table(score_array)
    score_array.each do |user_data|
      puts " #{score_array.index(user_data) + 1} | #{user_data[0].name.upcase} : #{user_data[1]}$"
    end
  end

  def empty_list
    puts "\n##################################\n"
    puts '         THE LIST IS EMPTY'
    puts "##################################\n"
  end

  def show_error(error)
    puts error.inspect
  end

  def skip_action_error
    "Already skiped action"
  end

  def taking_card_error
    "Already have full hand"
  end
end
