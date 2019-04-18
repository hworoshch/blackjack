class Game

  attr_accessor :bank
  attr_reader :pack

  def initialize
    @pack = Pack.new
    @bank = 0
  end

end
