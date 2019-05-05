require_relative 'interface'
require_relative 'accountant'
require_relative 'game_rules'
require_relative 'player'
require_relative 'gamer'
require_relative 'dealer'
require_relative 'card'
require_relative 'pack'

class Main
  include GameRules

  def initialize
    @accountant = Accountant.new
    @interface = Interface.new
  end

  def run
    create_players
    loop do
      reset_state
      first_deal
      play_game
      @interface.show_hands
      round_results
      break unless play_again?
    end
  end

  protected

  def create_players
    @gamer = Gamer.new(@interface.ask_name)
    @dealer = Dealer.new
  end

  def reset_state
    @pack = Pack.new
    [@gamer, @dealer].each { |player| player.new_hand }
  end

  def first_deal
    [@gamer, @dealer].each do |player|
      player.hand.add_cards(@pack.deal(2))
      @accountant.bet(player)
    end
  end

  def play_game
    loop do
      @interface.show_cards(@dealer, true)
      @interface.show_cards(@gamer)
      @interface.show_header(@gamer.name)
      @interface.show_menu(PLAYER_MENU)
      case @interface.players_choice
      when 2 then break if @gamer.hand.add_cards(@pack.deal)
      when 3 then break
      end
      @interface.header(@dealer.name)
      if @dealer.score < GameRules::DEALER_MAX_POINTS
        break if @dealer.hand.add_cards(@pack.deal)
      end
    end
  end

  def round_results
    winner = define_winner
    if winner.nil?
      @interface.show_draw
      @accountant.refund([@dealer, @gamer])
    else
      @interface.show_winner(winner)
      @accountant.reward_winner(winner)
    end
  end

  def define_winner
    return nil if @gamer.score == @dealer.score
    return nil if @gamer.excess? && @dealer.excess?
    @dealer if @gamer.excess?
    @gamer if @dealer.excess?
    [@gamer, @dealer].max_by(&:score)
  end

end
