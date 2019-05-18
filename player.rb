require 'forwardable'

class Player
  extend Forwardable
  include GameRules

  attr_reader :name, :hand, :bank
  def_delegators :hand, :add_cards, :cards, :score, :excess?

  def initialize(name)
    new_hand
    @bank = GameRules::DEFAULT_BANK
  end

  def can_take_card?
    !hand.full?
  end

  def enough_money?
    @bank >= GameRules::DEFAULT_BET 
  end

  def new_hand
    @hand = Hand.new
  end

  def withdraw(value)
    @bank -= value
  end

  def debit(value)
    @bank += value
  end
end
