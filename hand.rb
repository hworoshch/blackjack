class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def can_add_card?
    @cards.count < 3
  end

  def add_cards(cards)
    @cards += cards
  end

  def score
    sum = @cards.sum(&:value)
    ace_correction(sum)
  end

  def excess?
    score > GameRules::BJ
  end

  private

  def ace_correction(sum)
    @cards.each do |card|
      next unless card.ace?

      sum -= GameRules::ACE_CORRECTION if sum > GameRules::BJ
    end
    sum
  end
end
