class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def add_cards(cards)
    return false if @cards.count > 2

    @cards += cards
    true
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
  end
end
