class Accountant
  attr_reader :bank

  def initialize
    @bank = 0
  end

  def bet(player)
    player.withdraw(GameRules::BET)
    @bank += GameRules::BET
  end

  def reward_winner(winner)
  end

  def refund(*players)
  end
end
