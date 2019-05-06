class Accountant
  attr_reader :bank

  def initialize
    @bank = 0
  end

  def bet(player)
    player.withdraw(GameRules::DEFAULT_BET)
    @bank += GameRules::DEFAULT_BET
  end

  def reward_winner(winner)
    winner.debit(@bank)
    @bank = 0
  end

  def refund(*players)
    refund_amount = @bank / players.count
    players.each { |player| player.debit(refund_amount) }
    @bank = 0
  end
end
