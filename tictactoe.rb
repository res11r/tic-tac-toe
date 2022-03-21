class Player
  attr_reader :number, :symbol
  attr_accessor :won
  def initialize(number, symbol)
      @number = number
      @symbol = symbol
      @won = false
  end 
end 

class Board 
  attr_reader :grid, :player_one, :player_two
  attr_accessor :game_ended

  def initialize 
    @grid = (1..9).to_a
    @player_one = Player.new(1, 'x')
    @player_two = Player.new(2, 'o')
    @game_ended = false
  end 

  def play(player, grid_position)
    @grid[grid_position-1] = player.symbol
  end

  def check_win(player)
    if [@grid[0], @grid[1], @grid[2]] == [player.symbol]*3 || 
      [@grid[3], @grid[4], @grid[5]] == [player.symbol]*3 ||
      [@grid[6], @grid[7], @grid[8]] == [player.symbol]*3 ||
      [@grid[0], @grid[3], @grid[6]] == [player.symbol]*3 ||
      [@grid[1], @grid[4], @grid[7]] == [player.symbol]*3 ||
      [@grid[2], @grid[5], @grid[8]] == [player.symbol]*3 ||
      [@grid[0], @grid[4], @grid[8]] == [player.symbol]*3 ||
      [@grid[2], @grid[4], @grid[6]] == [player.symbol]*3 
      player.won = true
    end 
  end 

  def check_tie
    @grid.each do |cell| 
      if cell != @player_one.symbol && cell != @player_two.symbol 
        return
      end 
    end
    puts 'The game is a tie' 
    end_game
  end 
  def end_game
    @game_ended = true
  end
end

board = Board.new
# puts [board.grid[0], board.grid[1], board.grid[2]]

def display(board)
  puts "#{board.grid[0]} | #{board.grid[1]} | #{board.grid[2]} \n"
  puts "#{board.grid[3]} | #{board.grid[4]} | #{board.grid[5]} \n"
  puts "#{board.grid[6]} | #{board.grid[7]} | #{board.grid[8]}"
end

puts "Player #{board.player_one.number} is #{board.player_one.symbol}"
puts "Player #{board.player_two.number} is #{board.player_two.symbol}"

display(board)

while (board.game_ended == false)
  puts "Player 1's turn. Enter grid position (1-9):"
  print ">"
  grid_position = gets.chomp.to_i
  until board.grid[grid_position - 1] != board.player_two.symbol 
    puts "Position already chosen, try again"
    grid_position = gets.chomp.to_i
  end 
  board.play(board.player_one, grid_position)
  display(board)
  board.check_win(board.player_one)
  board.check_tie 
  break if board.game_ended == true 
  if board.player_one.won == true 
    board.game_ended == true 
    puts "Player 1 wins!"
    break
  end 
  puts "Player 2's turn. Enter grid position (1-9):"
  print ">"
  grid_position = gets.chomp.to_i 
  until board.grid[grid_position - 1] != board.player_one.symbol 
    puts "Position already chosen, try again"
    grid_position = gets.chomp.to_i
  end 
  board.play(board.player_two, grid_position)
  display(board)
  board.check_win(board.player_two)
  board.check_tie 
  break if board.game_ended == true 
  if board.player_two.won == true 
    board.game_ended == true 
    puts "Player 2 wins!"
    break
  end 
end
