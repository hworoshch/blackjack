class Game

  attr_accessor :bank
  attr_reader :pack

  def initialize
    @pack = Pack.new
    @bank = 0
  end

  def receive_bet(value = GameRules::DEFAULT_BET)
    @bank += value
  end

  def payment(value)
    return false if @bank < value
    @bank -= value
    true
  end

end
