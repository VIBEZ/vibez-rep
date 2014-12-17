class Ship

  attr_accessor :length, :hits, :direction, :position, :name, :attacked_parts

  def initialize(length, name)
    @length  = length
    @direction = 1
    @name = name
    @position = []
    @attacked_parts = 0
  end

  def update(x=0,y=0)
    @position << {:x=>x, :y=>y, :hits=>0}
  end
end

