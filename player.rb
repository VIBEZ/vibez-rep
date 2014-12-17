class Player

  attr_reader :name #:ships

  def initialize(name)
    # @ships = [ Ship.new(5, 'A'), Ship.new(4,'C'), Ship.new(3,'D1'), Ship.new(3,'D2'), Ship.new(2, 'S')]
    @name  = name
  end
end
