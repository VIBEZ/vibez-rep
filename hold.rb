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
  column     = reponse[0]
  row       = response[1]

  board.attack_position(column, row)
end