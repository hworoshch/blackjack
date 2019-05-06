class Gamer < Player
  def initialize(name = GameRules::DEFAULT_GAMER_NAME)
    @name = name
    super
  end
end
