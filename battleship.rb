BATTLESHIPS = ["Submarine",1, "Destroyer1",2, "Destroyer2",3,"Cruiser",4,"Aircraft Carrier",5]
@battleship = Array.new(10) { Array.new(10,0) }
@arr1 = Array.new(10) { Array.new(10,0 )}

def grid(battleship)
  battleship[0] = [" ",0,1,2,3,4,5,6,7,8,9]
  battleship[1] = [0]
  battleship[2] = [1]
  battleship[3] = [2]
  battleship[4] = [3]
  battleship[5] = [4]
  battleship[6] = [5]
  battleship[7] = [6]
  battleship[8] = [7]
  battleship[9] = [8]
  battleship[10]= [9]
end




def aircraft_carrier(arr1,battleship)

  row = rand(9)+1
  column = rand(5)+1
  battleship[row][column] = 's'
  battleship[row][column+1] = 's'
  battleship[row][column+2] = 's'
  battleship[row][column+3] = 's'
  battleship[row][column+4] = 's'
  arr1[row][column] = battleship[row][column]
  arr1[row][column+1] = battleship[row][column+1]
  arr1[row][column+2] = battleship[row][column+2]
  arr1[row][column+3] = battleship[row][column+3]
  arr1[row][column+4] = battleship[row][column+4]
end
def cruiser(arr1,battleship)

  row = rand(9)+1
  column = rand(6)+1
  until battleship[row][column] != 's' && battleship[row][column+1] != 's' && battleship[row][column+2] != 's'&& battleship[row][column+3] != 's' do
    row= rand(9)+1
    column= rand(6)+1
  end
  battleship[row][column] = 's'
  battleship[row][column+1] = 's'
  battleship[row][column+2] = 's'
  battleship[row][column+3] = 's'
  arr1[row][column] = battleship[row][column]
  arr1[row][column+1] = battleship[row][column+1]
  arr1[row][column+2] = battleship[row][column+2]
  arr1[row][column+3] = battleship[row][column+3]
end

def destroyer1(arr1,battleship)
  row = rand(7) +1
  column = rand(9) +1
  until battleship[row][column] !='s' && battleship[row+1][column] !='s' && !battleship[row+2][column] !='s' do
    row= rand(7) +1
    column= rand(9) +1
  end
  battleship[row][column] = 's'
  battleship[row+1][column] = 's'
  battleship[row+2][column] = 's'
  arr1[row][column]=battleship[row][column]
  arr1[row+1][column]=battleship[row+1][column]
  arr1[row+2][column]=battleship[row+2][column]
end

def destroyer2(arr1,battleship)
  row = rand(7) +1
  column = rand(9) +1
  until battleship[row][column] !='s' && battleship[row+1][column] !='s' && !battleship[row+2][column] !='s' do
    row= rand(7) +1
    column= rand(9) +1
  end
  battleship[row][column] = 's'
  battleship[row+1][column] = 's'
  battleship[row+2][column] = 's'
  arr1[row][column]=battleship[row][column]
  arr1[row+1][column]=battleship[row+1][column]
  arr1[row+2][column]=battleship[row+2][column]
end

def sub_marine(arr1,battleship)
  row = rand(8)+1
  column = rand(9)+1
  until  battleship[row][column] !='s' && battleship[row+1][column] !='s' do
    row = rand(8)+1
    column = rand(9)+1
  end
  battleship[row][column]='s'
  battleship[row+1][column]='s'
  arr1[row][column] = battleship[row][column]
  arr1[row+1][column]= battleship[row+1][column]
end




def grid1(battleship)
  battleship.each do|row|



    puts row.join(' ')

  end

end





grid(@battleship)
aircraft_carrier(@arr1,@battleship)
cruiser(@arr1,@battleship)
destroyer1(@arr1,@battleship)
destroyer2(@arr1,@battleship)
sub_marine(@arr1,@battleship)
grid1(@battleship)

