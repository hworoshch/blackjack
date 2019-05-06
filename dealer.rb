class Dealer < Player
  def initialize(name = GameRules::DEALER_NAME)
    @name = name
    super
  end
end
