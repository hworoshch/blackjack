require_relative 'interface'
require_relative 'accountant'
require_relative 'game_rules'
require_relative 'hand'
require_relative 'player'
require_relative 'gamer'
require_relative 'dealer'
require_relative 'card'
require_relative 'pack'

class Main
  include GameRules

  GAMER_ACTIONS = {
    skip: 0,
    add_card: 1,
    open_cards: 2
  }

  def initialize
    @accountant = Accountant.new
    @interface = Interface.new
  end

  def run
    create_players
    loop do
      break unless players_have_money?
      reset_state
      first_deal
      play_round
      show_hands
      round_results
      break unless @interface.play_again?
    end
  end

  protected

  def create_players
    @gamer = Gamer.new(@interface.ask_name)
    @dealer = Dealer.new
  end

  def players_have_money?
    [@gamer, @dealer].each do |player|
      unless player.enough_money?
        @interface.not_enough_money(player)
        return false
      end
    end
    return true
  end

  def reset_state
    @pack = Pack.new
    [@gamer, @dealer].each(&:new_hand)
  end

  def first_deal
    [@gamer, @dealer].each do |player|
      player.add_cards(@pack.deal(2))
      @accountant.bet(player)
    end
  end

  def play_round
    loop do
      @interface.show_cards(@dealer, true)
      @interface.show_cards(@gamer)
      gamer_action = gamer_turn
      break if gamer_action == GAMER_ACTIONS[:open_cards]
      dealer_turn
      break if round_ended?
    end
  end

  def gamer_turn
    @interface.show_header(@gamer.name)
    @interface.show_menu(Interface::PLAYER_MENU)
    case @interface.players_choice
    when 1
      GAMER_ACTIONS[:skip]
    when 2 
      return unless @gamer.can_take_card?
      @gamer.add_cards(@pack.deal)
      GAMER_ACTIONS[:take_card]
    when 3 
      GAMER_ACTIONS[:open_cards]
    end
  end

  def dealer_turn
    @interface.show_header(@dealer.name)
    return if @dealer.add_cards(@pack.deal)
  end

  def show_hands
    [@dealer, @gamer].each { |player| @interface.show_cards(player) }
  end

  def round_ended?
    !@gamer.can_take_card? && !@dealer.can_take_card?
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
    return if @gamer.score == @dealer.score
    return if @gamer.excess? && @dealer.excess?
    return @dealer if @gamer.excess?
    return @gamer if @dealer.excess?
    [@gamer, @dealer].max_by(&:score)
  end
end
