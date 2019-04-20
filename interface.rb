module Interface

  PLAYER_MENU = %w[
    Пропустить ход
    Добавить карту
    Открыть карты ].freeze

  def show_header(player_name)
    puts "\nХодит #{player_name}:"
  end

  def show_menu(menu)
    menu.each.with_index(1) { |item, index| puts "#{index}> #{item}" }
    puts "\n"
  end

  def ask_name
    puts "\nВаше имя: "
    gets.chomp.to_s
  end

  def show_cards(player, hidden = false)
    print "#{player.name} [банк #{player.bank}]:"
    if hidden
      player.cards.each { |card| print " *" }
      puts "\n"
    else
      player.cards.each { |card| print " #{card.suit}#{card.rank}" }
      puts ", очки: #{player.score}\n"
    end
  end

  def show_hands
    [@gamer, @dealer].each { |player| show_cards(player) }
    if winner.nil?
      puts "\nНичья!"
      #split_bank
    else
      puts "\nПобедил #{winner.name}"
      #withdraw(@game, winner)
    end
  end

  def play_again?
    puts "\nИграть еще раз? (1/0)"
    gets.to_i == 1
  end

end
