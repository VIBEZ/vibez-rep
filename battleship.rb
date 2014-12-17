require "colorize"
require_relative "ship"
require_relative "board"
require_relative "player"
require_relative "game"

def play
  print "Wanna play some Battleship? (Y/N)".colorize(:black)
  response = gets.chomp.strip.upcase

  unless response == "Y" or response == "N"
    puts "Invalid response, Try Again"
    print "Wanna play some Battleship? (Y/N) ".colorize(:black)
    response = gets.chomp.strip.upcase
  end

  if response == "Y"
    game = Game.new("game")
    puts game.set_player
    game.deploy_ships
    game.board.print_boards

    puts game.play_rounds
  else
    puts "Alrighty, Be sure to come back later"
  end

end

# Run the code
play
