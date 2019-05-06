require 'forwardable'

class Player
  extend Forwardable
  include GameRules

  attr_reader :name, :hand, :bank
  def_delegator :@hand, :add_cards, :add_cards
  def_delegator :@hand, :cards, :cards
  def_delegator :@hand, :score, :score
  def_delegator :@hand, :excess?, :excess?

  def initialize(*name)
    new_hand
    @bank = GameRules::DEFAULT_BANK
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
