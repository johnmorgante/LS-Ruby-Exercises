require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diags

NUM_WINS = 5
DEFAULT_NUMBER = 5

def prompt(msg)
  puts "=> #{msg}"
end

def greeting
  prompt("Welcome to Tic Tac Toe! You are playing agaisnt the Computer! The first one to 5 wins, wins! Good luck!")
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  # system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts " #{brd[1]}   |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts " #{brd[4]}   |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts " #{brd[7]}   |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

# rubocop:enable Metrics/AbcSize

def initalize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ' '
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry thats not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end
  
  if !square 
   WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, PLAYER_MARKER)
    break if square 
   end 
  end 
  
  if empty_squares(brd).include?(DEFAULT_NUMBER)
    square = DEFAULT_NUMBER 
  end 
  
  if !square
    square = empty_squares(brd).sample
  end
  
  brd[square] = COMPUTER_MARKER

end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
      return 'Player'
    elsif brd[line[0]] == COMPUTER_MARKER &&
          brd[line[1]] == COMPUTER_MARKER &&
          brd[line[2]] == COMPUTER_MARKER
      return 'Computer'
    end
  end
  nil
end

def first_turn(board, current_player)
   loop do 
     if current_player == "Computer"
       prompt("Computer decides who goes first!")
       sleep(1)
       go_first = [1,2].sample
        if go_first == 1
          prompt("Computer chose you!")
          prompt("Go ahead!")
          sleep(1.5)
          return "User"
        elsif go_first == 2
          prompt("Computer will go first!")
          sleep(1.5)
          return "Computer"
        else 
          prompt("Please choose '1' or '2'")
        end
     end
    
    
      if current_player == "User"
        prompt("You decide who goes first! Press '1' for you, '2' for computer")
        go_first = gets.chomp
        if go_first == "1"
           return "User"
        elsif go_first == "2"
            return "Computer"
        else 
          prompt("Please choose '1' or '2'")
        end
      end 
  end 
end
  

def update_score(scores, brd)
  if detect_winner(brd) == "Player"
    scores[:player_score] += 1
  elsif detect_winner(brd) == "Computer"
    scores[:computer_score] += 1
  end 
end

def display_score(scores)
  prompt("User win total: #{scores[:player_score]}
 Computer win total: #{scores[:computer_score]}")
 sleep(1)
end

def place_piece!(board, current_player)
  if current_player == "User"
    player_places_piece!(board)
  elsif current_player == "Computer"
    computer_places_piece!(board)
  else 
    prompt("Invalid Player")
  end 
end 

def alternate_player(current_player)
  if current_player == "User"
    current_player = "Computer"
  elsif current_player == "Computer"
    current_player = "User"
  end 
end 


  scores = { player_score: 0, computer_score: 0 }
  greeting
  
  loop do 
    board = initalize_board
    current_player = "Computer"
    current_player = first_turn(board, current_player)
    
    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end
  
    display_board(board)
  
    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
    else
      prompt "Its a tie!"
    end
    
   update_score(scores,board)
   
   display_score(scores)
    
  break if scores[:player_score] == NUM_WINS || scores[:computer_score] == NUM_WINS
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"

