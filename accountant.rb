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
    players.each { |player| player.debit(@bank/players.count) }
    @bank = 0
  end
end
