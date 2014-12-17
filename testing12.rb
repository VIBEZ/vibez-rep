class Board

  attr_accessor :grid

  NUM_SHIPS = 5
  BOARD_DIM = 10
  row = ['A','B','C','D','E','F','G','H','I','J']
  column = ['1','2','3','4','5','6','7','8','9','10']

  def initialize
    @grid = Array.new(BOARD_DIM).map! {Array.new(BOARD_DIM).map! {GridCell.new}}
  end

  def to_s
    row_letter = ('A'..'Z').to_a
    i = 0
    puts "  1 2 3 4 5 6 7 8 9 10".colorize(:green)
    @grid.each do |row|
      print row_letter[i].colorize(:green) + ' '
      row.each {|cell| print cell.to_s + ' '}
      print "\n"
      i += 1
    end
  end

  #Placement of em ships
  def place_ship(ship, start_position, orientation)
    row = start_position[:row]
    column = start_position[:column]
    ship.length.times do
      if orientation == :horizontal
        self.grid[row][column].ship = ship
        self.grid[row][column].status = :occupied
        column += 1
      else
        self.grid[row][column].ship = ship
        self.grid[row][column].status = :occupied
        row += 1
      end
    end
  end

  #validate ship placement remains within board
  def valid_coordinates?(ship, start_position, orientation)
    if orientation == :horizontal
      (start_position[:column] + ship.length) <= 10
    else
      (start_position[:row] + ship.length) <= 10
    end
  end

  #validate ship placement does not conflicts with another placed ship
  def check_clearance?(ship, start_position, orientation)
    row = start_position[:row]
    column = start_position[:column]
    ship.length.times do
      if self.grid[row][column].ship
        return false
      elsif orientation == :horizontal
        column += 1
      else
        row += 1
      end
    end
    return true
  end

  class GridCell

    attr_accessor :status, :ship

    FILL_CHAR = {:open => '+',
                 :hit => 'X',
                 :miss => '0'}

    def initialize(status = :open, ship = nil)
      @status = status
      @ship = ship
    end

    def to_s
      if @ship && @status != :hit
        @ship.to_s
      elsif @status == :hit
        FILL_CHAR[@status].colorize(:light_red)
      elsif @status == :miss
        FILL_CHAR[@status].colorize(:yellow)
      else
        FILL_CHAR[@status]
      end
    end

    def hit
      @status = :hit
    end

    def miss
      @status = :miss
      puts row.join('  ')
    end
  end
  puts row.join(' ')
end
