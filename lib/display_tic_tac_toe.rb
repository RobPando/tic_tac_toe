# tic_tac_toe.rb
require_relative 'tic_tac_toe'

class TicTacToeGame 
	def initialize
	end
end

print "Welcome, lets play Tic Tac Toe? yes/no: "
play_game = gets.downcase.strip
exit unless play_game == 'yes' || play_game == 'y'

puts "Great!, lets start!"
puts " "
game = TicTacToe.new
game.grid

begin
	print "How many players? 1 or 2 : "
	number_of_players = gets.strip
end until number_of_players == "1" || number_of_players == "2"

print "Name of player 1?: "
name1 = gets.downcase.capitalize.strip

begin
	print "Choose your symbol 'x' or 'o': "
	symbol1 = gets.downcase.strip
end until symbol1 == 'x' || symbol1 == 'o'

if number_of_players == "2"
	print "Name of player 2?: " 
	name2 = gets.downcase.capitalize.strip
end

symbol2 = symbol1 == 'x' ? 'o' : 'x'

player1 = Person.new(name1, symbol1)
player2 = number_of_players == "1" ? TicTacToe::AIComputer.new(symbol2) : Person.new(name2, symbol2)

turn = [player1, player2]
p = 1

while game.a_winner == false
	p = p == 0 ? p = 1 : p = 0 

	begin

		if number_of_players == "2" || p == 0
		print "It's #{turn[p].name}'s turn, choose a position: "
		position_number = gets.strip
		game.new_move(position_number.to_i, turn[p].sign)
		else
			turn[p].smart_move(game.positions) 
			game.new_move(turn[p].computer_move, turn[p].sign)
		end

	end until game.valid_move == true

break if game.a_winner == "draw"
end

if game.a_winner == true
	puts "#{turn[p].name} WINS!"
else
	puts "We have a draw!"
end
endit = gets.chomp











