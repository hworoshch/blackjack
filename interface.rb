class Interface
  PLAYER_MENU = [
    'Пропустить ход',
    'Добавить карту',
    'Открыть карты'
  ].freeze

  def show_header(player_name)
    ask "Ходит #{player_name}"
  end

  def show_menu(menu)
    menu.each.with_index(1) { |item, index| puts "#{index}> #{item}" }
  end

  def ask_name
    ask 'Ваше имя: '
    gets.chomp.to_s
  end

  def players_choice
    gets.to_i
  end

  def show_cards(player, hidden = false)
    print "#{player.name} [банк #{player.bank}]:"
    if hidden
      puts player.cards.map { ' *' }.join
    else
      cards = player.cards.map { |c| "#{c.suit}#{c.rank}" }
      puts " #{cards.join(' ')}, очки: #{player.score}"
    end
  end

  def show_draw
    say 'Ничья!'
  end

  def not_enough_money(player)
    say "#{player.name}: недостаточно денег для ставки"
  end

  def show_winner(winner)
    say "\nПобедил #{winner.name}!"
  end

  def play_again?
    ask 'Играть еще раз? (1/0)'
    gets.to_i == 1
  end

  def say(message)
    puts "#{message}\n"
  end

  def ask(message)
    puts "\n#{message}"
  end
end
