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
    winner.debit(@bank)
    @bank = 0
  end

  def refund(*players)
    refund_amount = @bank / players.count
    players.each { player.debit(refund_amount) }
    @bank = 0
  end
end
