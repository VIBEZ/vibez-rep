class Board
  attr_accessor :grid, :direction, :position, :name, :col_num, :row_num

  def initialize(char = ' ')
    set_grid(char)
  end

  def set_grid(char = ' ')
    @grid = Array.new(10).map! { Array.new(10, char) }
  end

  def valid_position(ship, position, orientation)
    column = position[:col_num]
    row    = position[:row_num]

    if orientation == :vertical
      (0...ship.length).each do |number|
        valid = !grid[column][row + number].nil? || grid[column][row + number] == ' ' ? true : false
        return false if valid == false
      end
    elsif orientation == :horizontal
      (0...ship.length).each do |number|
        return false if grid[column + number].nil?
        valid = !grid[column + number][row].nil? || grid[column + number][row] == ' ' ? true : false
        return false if valid == false
      end
    end

    place_ship(ship, position, orientation)
  end

  def print_boards
    col_num = *(0..9)
    row_num = *(0..9)

    puts ""
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

  def attack_position(column, row)
    # check if the position is empty or not
    # if water
    #   grid[column][row] = 'WATER'
    # elsif ship
    #   grid[column][row] = 'SHIP'
    # end
    # print_boards
  end

end
