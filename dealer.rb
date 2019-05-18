class Dealer < Player
  def initialize(name = GameRules::DEALER_NAME)
    @name = name
    super
  end

  def can_add_card?
    super && score < GameRules::DEALER_MAX_POINTS
  end
end
