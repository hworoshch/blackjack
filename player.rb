class Player

  attr_accessor :cards, :bank
  attr_reader :score, :name

  def initialize(*name)
    @bank = 100
    @cards = []
  end

  # при переборе найти туз в колоде и установить value в 1

  def score
    @score = 0
    @cards.each { |card| @score += card.value }
    @score
  end

  def excess?
    return true if @score > 21
  end

  def check_aces!
    @cards.each do |card|
      next unless card.rank == 'A' && card.value == 10
      discount_ace!(card)
      true
    end
  end

end
