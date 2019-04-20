require_relative 'interface'
require_relative 'accountant'
require_relative 'game'
require_relative 'game_rules'
require_relative 'player'
require_relative 'gamer'
require_relative 'dealer'
require_relative 'card'
require_relative 'pack'

class Main
  include GameRules
  include Interface

  def run
    create_players
    loop do
      reset_hands
      @game = Game.new
      @accountant = Accountant.new
      first_deal
      play_game
      show_hands
      if winner.nil?
        show_draw
        @accountant.refund([@dealer, @gamer])
      else
        show_winner(winner)
        @accountant.reward_winner(winner)
      end
      break unless play_again?
    end
  end

  protected

  def create_players
    @gamer = Gamer.new(ask_name)
    @dealer = Dealer.new
  end

  def reset_hands
    [@gamer, @dealer].each { |player| player.new_hand }
  end

  def first_deal
    [@gamer, @dealer].each do |player|
      player.hand.add_cards(@game.pack.deal(2))
      @accountant.bet(player)
    end
  end

  def play_game
    loop do
      show_cards(@dealer, true)
      show_cards(@gamer)
      show_header(@gamer.name)
      show_menu(PLAYER_MENU)
      case players_choice
      when 2 then break if @gamer.hand.add_cards(@game.pack.deal)
      when 3 then break
      end
      header(@dealer.name)
      if @dealer.score < GameRules::DEALER_MAX_POINTS
        break if @dealer.hand.add_cards(@game.pack.deal)
      end
    end
  end

  def winner
    return nil if @gamer.score == @dealer.score
    return nil if @gamer.excess? && @dealer.excess?
    @dealer if @gamer.excess?
    @gamer if @dealer.excess?
    [@gamer, @dealer].max_by(&:score)
  end

end
