class Pack
  def initialize
    create_pack!
  end

  def deal(cards_count = 1)
    to_hand = []
    cards_count.times do
      to_hand << cards.shift
    end
    to_hand
  end

  def cards
    @cards ||= []
  end

  private

  def create_pack!
    GameRules::CARD_SUITS.each do |suit|
      GameRules::CARD_RANKS.each do |rank|
        cards << Card.new(suit, rank)
      end
    end
    cards.shuffle!
  end
end
