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

  def play_rounds
    puts "\n\nTime to sink some ships! Good luck, #{@player.name}\n\n"
    game_over = false
    while game_over == false
      @board.print_boards
      player_round
      if ships_left == 0
        winner = @player.name
        game_over = true
        next
      end
    end
    puts "\n\n#{winner} WINS!\n\n".colorize(:light_blue)
  end

  def play_round
    print "ASDLKASDKASD"
    response  = gets.chomp.strip.upcase.split('//')
    colum     = reponse[0]
    row       = response[1]

    board.attack_position(column, row)
  end
end
