class Dealer < Player

  def initialize(name = GameRule::DEALER_NAME)
    @name = name
    super
  end

end
