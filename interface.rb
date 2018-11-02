class Interface
  def main_menu
    puts "\n----------------------------------------------"
    puts "\u2663 \u2666 \u2665 \u2660  WELCOME TO \"BlackJack\" GAME! \u2663 \u2666 \u2665 \u2660"
    puts "----------------------------------------------"
    puts "          |Press '1' - Start a game|          "
    puts "          |Press '0' - Exit        |          "
    puts "----------------------------------------------"
  end

  def starting
    puts "\n\u2663 \u2666 \u2665 \u2660  THE GAME STARTING \u2663 \u2666 \u2665 \u2660"
    puts "------------------------------------\n"
  end

  def ask_choice
    loop do
      puts "\nPress a number from menu ('0' - back/quit):"
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

  def show_hand(user)
    print "\n\n#{user.name} cards: |"
    if user.instance_of?(User)
      user.cards_in_hand.each { |card| print "#{card}|" }
    else
      user.cards_in_hand.each { |card| print "*|"}
    end
  end

end