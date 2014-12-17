class Game

  attr_reader :name, :ship, :player, :board

  def initialize(name)
    @name = name
    @board = Board.new
    @target_board = Board.new
    @ships = [ Ship.new(5, 'A'), Ship.new(4,'C'), Ship.new(3,'D1'), Ship.new(3,'D2'), Ship.new(2, 'S')]
  end

  def to_s
    @name
  end

  #print side-by-side ship status and shots taken boards
  def print_boards
    puts "      SHIP STATUS                   SHOTS TAKEN".colorize(:black)
    puts "  1 2 3 4 5 6 7 8 9 10          1 2 3 4 5 6 7 8 9 10".colorize(:black)
    row_letter = ('A'..'Z').to_a
    row_number = 0
    @board.grid.each do |row1|
      print row_letter[row_number].colorize(:black) + ' '
      row1.each {|cell| print cell.to_s + ' '}
      print "        "
      print row_letter[row_number].colorize(:black) + ' '
      @target_board.grid[row_number].each {|cell| print cell.to_s + ' '}
      print "\n"
      row_number += 1
    end
  end

  def set_player
    name = ''
    while name.empty? do
      print "Enter name: "
      name = gets.chomp.strip
      @player = Player.new(name)
    end
  end

  def deploy_ships
    valid = false
    while valid == false do
      print "\n"
      print_boards                        #print board for reference
      position = {}
      player.ships.each do |ship|
        while valid == false do
          print "\n#{ship.name.capitalize} orientation: horizontal(H) or vertical(V)? "
          input = gets.chomp.strip.upcase
          if input == 'H' || input == 'HORIZONTAL'
            orientation = :horizontal
            valid = true
          elsif input == 'V' || input == 'VERTICAL'
            orientation = :vertical
            valid = true
          else
            puts "Invalid orientation entry.".colorize(:light_yellow)
          end
        end
        valid = false
        while valid == false do
          print "\n#{ship.name.capitalize} starting position  "
          input = gets.chomp.rstrip.upcase
          position[:row_num] = Board::COL_NUM.rindex(input.split("//", 2)[0])
          position[:col_num] = Board::ROW_NUM.rindex(input.split("//", 2)[1])
          puts position.inspect
          if !position[:row_num].nil? && !position[:col_num].nil?
            valid = true
          else
            puts "Invalid coordinates.".colorize(:yellow)
          end
        end
        valid = false
        if board.place_ship(ship, position, orientation )
          valid = true
        else
          puts "Invalid position for ship.".colorize(:yellow)
        end
      end
    end
  end

  def play_rounds
    puts "\n\nTime to sink some ships! Good luck, #{@player.name}\n\n"
    game_over = false
    while game_over == false
      @player.print_boards
      player_round
      if ships_left == 0
        winner = @player.name
        game_over = true
        next
      end
    end
    puts "\n\n#{winner} WINS!\n\n".colorize(:light_blue)
  end
end
