class Interface
  def main_menu
    puts "\n----------------------------------------------"
    puts "\u2663 \u2666 \u2665 \u2660  WELCOME TO \"BlackJack\" GAME! \u2663 \u2666 \u2665 \u2660"
    puts "----------------------------------------------"
    puts "          |Press '1' - Start a game|          "
    puts "          |Press '0' - Exit        |          "
    puts "----------------------------------------------"
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
    puts "\n[Menu variant like that doesn't exist]\n"
  end

  def ask_player_name
    loop do
      puts "\nEnter your name: "
      player_name = gets.chomp
      break(player_name) unless player_name.empty?
    end    
  end

  def balance_info(user)
    print "| #{user.name}'s balance is #{user.balance}$ "
    print "|"
  end

  def show_hand(user, option)
    print "\n#{user.name} cards: |"
    user.cards_in_hand.each do |card|
      if user.instance_of?(User) || option == :all_users
        print "#{card}|"
      else
        print "*|"
      end
    end
  end

  def taking_a_bet
    puts "\n\n###################################"
    puts " Each player is giving a bet - 10$  "
    puts "###################################\n\n"
  end

  def getting_on_a_cards
    puts "\n\n##################################"
    puts "   Players are getting on cards       "
    puts "##################################"    
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
    puts "--------------------------"
    puts "\n1 - Take one more card\n2 - Skip\n3 - Show all cards"    
  end

  def dealer_actions
    puts "\n\n######################################"
    puts "      Dealer is doing his choise      "
    puts "######################################"  
  end

  def dealer_skiped_action
    puts "\nDealer skiped action"
    puts "Now is YOUR turn"
  end

  def player_skiped_action
    puts "\nYou skiped action"
    puts "Now is DEALER turn"    
  end

  def dealer_taked_card
    puts "\nDealer taked one more card"
    puts "Now is YOUR turn"
  end

  def player_taked_card
    puts "\nYou taked one more card"
    puts "Now is DEALER turn"    
  end

  def end_screen
    puts "\n\u2663 \u2666 \u2665 \u2660  THE GAME IS OVER \u2663 \u2666 \u2665 \u2660"
    puts "----------------------------------\n"
    puts "             FINAL RESULTS              "
    puts "----------------------------------\n"
  end

  def declare_the_victory_by(user)
    congratilation = "HOLY SON OF LUCKY!!! THE WINNER IS - #{user.name.upcase}"
    puts "\n"
    congratilation.length.times { print "$" }
    puts "\n\n#{congratilation}\n\n"
    congratilation.length.times { print "$" }
    puts "\n\n"
  end

  def declare_the_dead_heat
    congratilation = "DRAW: THERE IS NO THE ONE WINNER"
    puts "\n"
    congratilation.length.times { print "@" }
    puts "\n\n#{congratilation}\n\n"
    congratilation.length.times { print "@" }
    puts "\n\n"
  end

end