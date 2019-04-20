class Hand

  attr_accessor :cards
  attr_reader :score

  def initialize
    @cards = []
  end

  def add_cards(cards)
    return false if @cards.count > 2
    @cards += cards
    true
  end

  def score
    count_score
    until excess?
      aces_found = check_aces!
      count_score
      break unless aces_found
    end
    @score
  end

  def count_score
    @score = 0
    @cards.each { |card| @score += card.value }
  end

  def excess?
    @score > GameRules::BJ
  end

  def check_aces!
    result = false
    @cards.each do |card|
      next unless card.rank == 'A' && card.value == 10
      card.value = 1
      result = true
      break
    end
    result
  end  

end
