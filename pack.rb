class Pack

  CARD_SUITS = ['♠', '♥', '♦', '♣']
  CARD_RANKS = [*('2'..'10'), 'J', 'K', 'Q', 'A']

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
    CARD_SUITS.each do |suit|
      CARD_RANKS.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    @cards.shuffle!
  end
end
