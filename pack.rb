class Pack
  attr_reader :cards

  def initialize
    @cards = []
    create_pack!
  end

  def deal(cards = 1)
    to_hand = []
    cards.times do
      to_hand << @cards.shift
    end
    to_hand
  end

  private

  def create_pack!
    GameRules::CARD_SUITS.each do |suit|
      GameRules::CARD_RANKS.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    @cards.shuffle!
  end
end
