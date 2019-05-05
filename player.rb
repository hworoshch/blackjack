require 'forwardable'

class Player
  extend Forwardable
  include GameRules

  attr_reader :name
  attr_accessor :hand
  def_delegator :@hand, :add_cards, :add_cards

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
