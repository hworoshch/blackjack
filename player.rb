class Player
  
  include GameRules

  attr_accessor :cards, :bank
  attr_reader :score, :name

  def initialize(*name)
    @bank = 100
    @cards = []
  end

  def add_cards(cards)
    return false if @cards.count > 2
    @cards += cards
    true
  end

  def score
    @score = 0
    @cards.each { |card| @score += card.value }
    @score
  end

  def excess?
    @score > GameRules::BJ
  end

  def check_aces!
    @cards.each do |card|
      next unless card.rank == 'A' && card.value == 10
      discount_ace!(card)
      true
    end
  end

end
