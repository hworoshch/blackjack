class Pack

  CARD_SUITS = ['♠', '♥', '♦', '♣']
  CARD_RANKS = [*('2'..'10'), 'J', 'K', 'Q', 'A']

  attr_reader :cards

  def initialize
    @cards = []
    create_pack!
  end

  def deal(player, cards = 1)
    cards.times do
      player.cards << @cards.shift
    end
  end

  private

  def create_pack!
    CARD_SUITS.each do |suit|
      CARD_RANKS.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    @cards.shuffle!
  end
end
