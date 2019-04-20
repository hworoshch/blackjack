class Player
  include GameRules

  attr_reader :name
  attr_accessor :hand

  def initialize(*name)
    @bank = 100
    new_hand
  end

  def new_hand
    @hand = Hand.new
  end

  def withdraw(value)
    @bank += value
  end

  def bet(value = GameRules::DEFAULT_BET)
    return false if @bank < value
    @bank -= value
    true
  end

end
