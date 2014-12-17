require "colorize"

class Ship

  attr_accessor :length, :hits, :direction, :position, :name

  def initialize(length, name)
    @length  = length
    @direction = 1
    @name = name
    @position = []

  end

  def update(x=0,y=0)
    @position << {:x=>x, :y=>y, :hits=>0}
  end

end



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

  def place_ship(ship, start_position, orientation)
    puts "i'm gonna place a ship"
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

  #validate ship placement conflicts with another placed ship
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

  end

  class Player

    attr_reader  :ships, :name

    def initialize(name)
      @ships = [ Ship.new(5, 'A'), Ship.new(4,'C'), Ship.new(3,'D1'), Ship.new(3,'D2'), Ship.new(2, 'S')]
      @name  = name
    end
  end



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
      puts "      SHIP STATUS                   SHOTS TAKEN".colorize(:light_red)
      puts "  1 2 3 4 5 6 7 8 9 10          1 2 3 4 5 6 7 8 9 10".colorize(:green)
      row_letter = ('A'..'Z').to_a
      row_number = 0
      @board.grid.each do |row1|
        print row_letter[row_number].colorize(:green) + ' '
        row1.each {|cell| print cell.to_s + ' '}
        print "        "
        print row_letter[row_number].colorize(:green) + ' '
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






  def play
    print "Wanna play some Battleship? (Y/N)".colorize(:light_green)
    response = gets.chomp.strip.upcase

    unless response == "Y" or response == "N"
      puts "Invalid response, Try Again"
      print "Wanna play some Battleship? (Y/N) ".colorize(:light_green)
      response = gets.chomp.strip.upcase
    end
    puts response
    if response == "Y"
      start = Game.new("game")
      puts start.set_player
      start.deploy_ships
      start.Board.print_boards

      while response == "Y"
        puts set_player
        puts play_round
      end
    else
      puts "Alrighty, Be sure to come back later"
    end

  end

  play

