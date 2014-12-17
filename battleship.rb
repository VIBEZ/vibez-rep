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
