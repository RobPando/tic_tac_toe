
class TicTacToe
	attr_reader :a_winner, :positions, :valid_move

	def initialize
	@positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	@a_winner = false
	@valid_move = true
	end

	def grid
		(1...10).each { |i| print_grid(i) } 
		puts ""
	end

	def print_grid(boxes)
		verticle = "||"
		horizontal = "===||===||==="
		print " #{positions[boxes-1]} "; 
		puts "" if boxes % 3 == 0; 
		print "#{verticle}" unless boxes % 3 == 0; 
		puts "#{horizontal}" if boxes == 3 || boxes == 6
	end

	def new_move(number, mark) 
		validate_move(number)	#Validates whether the move is possible or not
		draw(number, mark) if valid_move == true # if it is possible it marks its on the grid
	end

protected

	def draw(number, mark)
		positions[number - 1] = mark #replaces the number with the player's mark so it displays on the grid
		grid
		winner?
	end

	def validate_move(number)
		if positions[number - 1].is_a?(Integer) && number.between?(1, 9) #It is a valid move only if the number the user selected is between 1 and 9, ALSO checks if is not taken already.
			valid_move = true
		else
			valid_move = false
		end
	end

private
	def winner? #Based on all the winning lines, checks if the same mark is printed in all 3 of the winning positions
		(0...winning_positions.size).each { |i| check_position(i) }
		@a_winner = "draw" if @positions.all? { |x| x.is_a? String } && @a_winner == false
	end

	def check_position(number)
		combo = winning_positions[number]
		if @positions.values_at(*combo) == ['x', 'x', 'x'] || @positions.values_at(*combo) == ['o', 'o', 'o'] #Check if the values in one of the winning positions match 'o' or 'x'
			@a_winner = true
		end
	end

	def winning_positions
		@win_position = [[0,1,2], [0,3,6], [0,4,8], [6,7,8], [2,5,8], [1,4,7], [3,4,5], [2,4,6]] #Position for all winning posibilties
	end

	class AIComputer
		attr_reader :computer_move, :sign, :name
	
		def initialize(sign)
			@sign = sign
			@name = "The Computer"
			@computer_move = nil #returns this value to be placed in the grid
			@moves_already_selected = [] #all the moves that are already occupied.
			@collect_index = [] #All the moves made by the AI
			@collect_enemy_index = [] # All the moves made by the player
		end

		def smart_move(positions) #Method in charge of the moves, if is the first move sends to first_move method.
			if @computer_move == nil
				first_move(positions)
			else
				make_a_move(positions)
			end
		end

		protected

		def first_move(positions) #first move will always be the middle one unless is taken
			human_move = 0
			positions.each { |x| human_move = positions.index(x) if x.is_a? String }
			@collect_enemy_index << human_move
			@moves_already_selected << human_move
			if human_move == 4
				begin
					@computer_move = rand(1..9)
				end while @computer_move == 5
			else
				@computer_move = 5
				@moves_already_selected << @computer_move
				@collect_index << @computer_move
			end
		end

		def make_a_move(positions) #itirates through each posibility and checks if the player1 marked 2 of them, AI then takes the third to avoid loosing.
			move_tracker(positions)
			made_move = false
			last_chance = 0
			win_win = [[0,1,2], [0,3,6], [0,4,8], [6,7,8], [2,5,8], [1,4,7], [3,4,5], [2,4,6]] #All winning possibilities
			
			(0...win_win.size).each { |x| 
				checker = 0
				(0...win_win[x].size).each { |n|  
					if @collect_enemy_index.include?(win_win[x][n])
						checker += 1
					else
						last_chance = win_win[x][n] + 1 # keeps track on the last winning index so it can mark it to avoid loosing.
						checker -= 1 if @collect_index.include?(win_win[x][n])
					end }

				if checker == 2 #checks if 2 of 3 winning moves are taken and takes the 3rd.
					@computer_move = last_chance
					@collect_index << last_chance - 1
					made_move = true
					break
				end }

			if made_move == false
				random_move
			end

		end

		def move_tracker(positions) #Records everything that is going on, all the player1 move, all the AI move and both together
			(0...positions.size).each { |x| save_moves(x, positions) }
		end

		def save_moves(x, positions)
			if positions[x].is_a?(String)
				@collect_enemy_index << x unless @collect_enemy_index.include?(x) || positions[x] == @sign
				@collect_index << x unless @collect_index.include?(x) || positions[x] != @sign
				@moves_already_selected << x + 1 unless @moves_already_selected.include?(x + 1)
			end 
		end

		private

		def random_move #random move in the case of no threats
			begin
				@computer_move = rand(1..9)
			end while @moves_already_selected.include?(@computer_move)
				@moves_already_selected << @computer_move
		end
	end

end

class Person
		attr_reader :name, :sign

		def initialize(name, sign)
			@name = name
			@sign = sign
		end

	end

