  require "colorize"

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

  class Board
    attr_accessor :grid, :direction, :position, :name, :col_num, :row_num, :shots

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


         # Checks if player shot was a miss and updates both the board grid and the shots grid
          def check_shot(x = 0, y = 0)

            # If chosen position hasn't already been a missed('M'), execute check_ship and update_shots if
            # chosen position isn't empty('0')
            if board.grid[x][y]  != 'M'
              if board.grid[x][y] != '0'
                check_ship(x,y)
                update_shots(x,y)

                # Shot missed, so replace guess position on the board grid with value 'M'(missed) and on the shot
                # grid with value 'W'(water)
              else
                puts 'You missed!'
                @board.grid[x][y] = 'M'
                @shots.grid[x][y]='W'.colorize(:background => :blue, :color => :blue)
              end

              # Position already guessed. Still counts as a try
            else
              puts 'Already guessed here, unfortunately try counts.'
            end

          end # End of check_shot method

          # Checks if player shot was a hit and if all ships have been sunk
          def check_ship  (x,y)

            # If player guess is not already a hit and the position is occupied by the ship update the hit value from '0' to '1'
            if board.grid[x][y] != 'X'
              s = ships.detect { |s| s.name == board.grid[x][y] }
              puts 'Ship hit!!!'
              s.pos.each do |p|
                if p[:x] == x and p[:y] == y
                  p[:hit] = 1
                end
              end

              # If none of the ships hit values is a '0' then ship is sunk
              sink = s.pos.detect { |p| p[:hit] == 0 }
              if sink.nil?
                puts 'Ship '+s.name+' was sunk!!'
              end
            else
              puts 'You dont win if you hit the same place multiple times, the try still counts though.'
            end

           end # End of check_ship method

         # For each ship generate store position placed in it
          def update_pos(x=0,y=0)

            # E.g. for a yet to be hit submarine placed at starting position (0,0) horizontally, pos will be:
            # pos [ {:x => 0, :y => 0, :hit => 0 }, {:x => 1, :y => 0, :hit => 0 } ]
            @pos << {:x => x, :y => y, :hit => 0 }

          end # End of update_pos method
      [
        # For each ship generate store position placed in it
          def update_pos(x=0,y=0)

            # E.g. for a yet to be hit submarine placed at starting position (0,0) horizontally, pos will be:
            # pos [ {:x => 0, :y => 0, :hit => 0 }, {:x => 1, :y => 0, :hit => 0 } ]
            @pos << {:x => x, :y => y, :hit => 0 }

          end # End of update_pos method

          # Check win conditions

          def check_win
            win = true
           # For each ship check if none of the hit key values is 0(is not sunk). If false game isn't over.
            ships.each do |s|
              sink = s.pos.detect { |p| p[:hit] == 0 }
              if !sink.nil?
                win = false
                break
              end
            end
            if win
              puts 'Whoop Whoop!!'
            end
            win

          end # End of check_win method

      # check if the position is empty or not
      # if water
      #   grid[column][row] = 'WATER'
      # elsif ship
      #   grid[column][row] = 'SHIP'
      # end
      # print_boards
    end


  class Game

    attr_reader :name, :ships, :player, :board

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
      puts "      SHIP STATUS                   SHOTS TAKEN".colorize(:white)
      puts "  1 2 3 4 5 6 7 8 9 10          1 2 3 4 5 6 7 8 9 10".colorize(:white)
      row_letter = ('A'..'Z').to_a
      row_number = 0
      @board.grid.each do |row1|
        print row_letter[row_number].colorize(:white) + ' '
        row1.each {|cell| print cell.to_s + ' '}
        print "        "
        print row_letter[row_number].colorize(:white) + ' '
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
        @player = player.new(name)
      end
    end

    def deploy_ships
      valid = false
      print "\n"
      print_boards
      position = {}
      ships.each do |ship|
        valid = false
        while valid == false
          # SET SHIP ORIENTATION
          print "\n#{ship.name.capitalize} set orientation"
          orientation = Random.rand > 0.5 ?  :horizontal : :vertical
          print "\n#{ship.name.capitalize}'s orientation: #{position.inspect}"

          # SET SHIP POSITION
          print "\n#{ship.name.capitalize} set starting position"
          position[:row_num] = Random.rand(10)
          position[:col_num] = Random.rand(10)
          valid = true if board.valid_position(ship, position, orientation)
        end
      end
    end



  end


  def play
    print "Wanna play some Battleship? (Y/N)".colorize(:white)
    response = gets.chomp.strip.upcase

    unless response == "Y" or response == "N"
      puts "Invalid response, Try Again"
      print "Wanna play some Battleship? (Y/N) ".colorize(:white)
      response = gets.chomp.strip.upcase
    end

    if response == "Y"
      game = Game.new("game")
      puts game.set_player
      game.deploy_ships
      game.board.print_boards

      puts game.play_rounds
      puts game.check_shot
      puts game.check_ship
      puts game.update_pos
      puts game.check_win
    else
      puts "Alrighty, Be sure to come back later"
    end

  end

  # Run the code
  play