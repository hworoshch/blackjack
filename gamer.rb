class Gamer < Player

  NAME = 'Игрок'
  
  def initialize(name = NAME)
    @name = name
    super
  end

end
