class Card
  attr_reader :rank, :suit
  attr_accessor :value

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @value = get_value
  end

  def ace?
    card.rank == 'A'
  end

  protected

  def get_value
    if ('2'..'10').to_a.include?(@rank)
      @rank.to_i
    elsif ['J', 'Q', 'K'].include?(@rank)
      10
    elsif @rank == 'A'
      11
    end
  end
end
