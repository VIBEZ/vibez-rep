class Board

  attr_accessor :grid, :direction, :position, :name, :col_num, :row_num

  COL_NUM = "0123456789"
  ROW_NUM = "0123456789"

  def initialize(char = ' ')
    set_grid(char)
  end

  def set_grid(char = ' ')
    @grid = Array.new(10).map! { Array.new(10, char) }
  end

  def print_board
    col_num = *(0..9)
    row_num = *(0..9)

    print "\t"
    print row_num.join("\t")
    puts
    puts

    grid.each_with_index do |d, j|
      print col_num[j]
      print "\t"
      print d.join("\t")
      puts
      puts
    end
  end

  def place_ship(ship, position, orientation)
    "I'm about to place a ship"
    puts ship.inspect
    puts position.inspect
    puts orientation.inspect
  end

end
