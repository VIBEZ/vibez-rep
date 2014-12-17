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
    start = Game.new("game")
    puts start.set_player
    start.deploy_ships
    start.board.print_boards

    puts start.play_rounds
  else
    puts "Alrighty, Be sure to come back later"
  end

end

# Run the code
play
