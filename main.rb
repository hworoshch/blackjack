require_relative 'interface'
require_relative 'game'
require_relative 'player'
require_relative 'gamer'
require_relative 'dealer'
require_relative 'card'
require_relative 'pack'

class Main

  DEFAULT_BET = 10

  def run
    create_players
    loop do
      reset_hands
      @game = Game.new
      first_deal
      play_game
      show_hands
      break unless play_again?
    end
  end

  protected

  def play_game
    loop do
      show_cards(@dealer, true)
      show_cards(@gamer)
      puts "\nХодит #{@gamer.name}:"
      puts "1. Пропустить ход"
      puts "2. Добавить карту"
      puts "3. Открыть карты"
      case gets.to_i
      when 2 then break if @gamer.add_cards(@game.pack.deal)
      when 3 then break
      end
      puts "\nХодит #{@dealer.name}:"
      if @dealer.score < 17
        break if @dealer.add_cards(@game.pack.deal)
      end
    end
  end

  def create_players
    puts "\nВаше имя: "
    gamer_name = gets.chomp.to_s
    @gamer = Gamer.new(gamer_name)
    @dealer = Dealer.new
  end

  def reset_hands
    [@gamer, @dealer].each { |player| player.cards = [] }
  end

  def first_deal
    [@gamer, @dealer].each do |player|
      player.add_cards(@game.pack.deal(2))
      withdraw(player, @game, 10)
    end
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

  def winner
    return nil if @gamer.score == @dealer.score
    @dealer if @gamer.excess?
    @gamer if @dealer.excess?
    @gamer.score > @dealer.score ? @gamer : @dealer
  end

  def show_hands
    [@gamer, @dealer].each { |player| show_cards(player) }
    if winner.nil?
      puts "\nНичья!"
      split_bank
    else
      puts "\nПобедил #{winner.name}"
      withdraw(@game, winner)
    end
  end

  def withdraw(from, to, value = from.bank)
    from.bank -= value
    to.bank += value
  end

  def split_bank
    value = @game.bank / 2
    [@gamer, @dealer].each { |player| withdraw(@game, player, value) }
  end

  def play_again?
    puts "\nИграть еще раз? (1/0)"
    true if gets.to_i == 1
  end
end
