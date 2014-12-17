class Board
  attr_accessor :grid, :direction, :position, :name, :col_num, :row_num

  def initialize(char = ' ')
    set_grid(char)
  end

  def set_grid(char = ' ')
    @grid = Array.new(10).map! { Array.new(10, char) }
  end

  def print_boards
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
    column = position[:col_num]
    row    = position[:row_num]
    grid[column][row] = ship.name

    if orientation == :vertical
      (0...ship.length).each do |number|
        grid[column][row + number] = ship.name
      end
    elsif orientation == :horizontal
      (0...ship.length).each do |number|
        grid[column + number][row] = ship.name
      end
    end
  end

end
