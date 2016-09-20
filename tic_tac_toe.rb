
class TicTacToe
	attr_reader :a_winner, :positions, :valid_move

	def initialize
	@positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	@a_winner = false
	@valid_move = true
	end

	def grid
		verticle = "||"
		horizontal = "===||===||==="
		(1...10).each { |i| 
			print " #{@positions[i-1]} "; 
			puts "" if i % 3 == 0; 
			print "#{verticle}" unless i % 3 == 0; 
			puts "#{horizontal}" if i == 3 || i == 6 
		} 
		puts ""
	end

	def new_move(number, mark) # FIXME- check if there is no more moves and return false to end the game in a draw
		validate_move(number)
		draw(number, mark) if @valid_move == true
	end
#TODO: MAKE all the methods private, and see what is absolutely necesary to make public.
protected

	def draw(number, mark)
		@positions[number - 1] = mark
		grid
		winner
	end

	def validate_move(number)
		if @positions[number - 1].is_a?(Integer) && number.between?(1, 9)
			@valid_move = true
		else
			@valid_move = false
		end
	end

private
	def winner

		(0...winning_positions.size).each { |i|
			combo = winning_positions[i]
			if @positions.values_at(*combo) == ['x', 'x', 'x'] || @positions.values_at(*combo) == ['o', 'o', 'o'] #Check if the values in one of the winning positions match 'o' or 'x'
				@a_winner = true
			end
		}
		@a_winner = "draw" if @positions.all? { |x| x.is_a? String } && @a_winner == false
	end
	def winning_positions
		@win_position = [[0,1,2], [0,3,6], [0,4,8], [6,7,8], [2,5,8], [1,4,7], [3,4,5], [2,4,6]] #Position for all winning posibilties
	end

	class AIComputer
		attr_reader :computer_move, :sign, :name
	
		def initialize(sign)
			@sign = sign
			@name = "The Computer"
			@computer_move = nil
			@moves_already_selected = []
			@collect_index = []
			@collect_enemy_index = []
		end

		def smart_move(positions)
			if @computer_move == nil
				first_move(positions)
			else
				make_a_move(positions)
			end
		end

		protected

		def first_move(positions)
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
				puts "we in first_move method #{@computer_move}"
				@moves_already_selected << @computer_move
				@collect_index << @computer_move
			end
		end

		def make_a_move(positions)
			move_tracker(positions)
			made_move = false
			
			last_chance = 0
			win_win = [[0,1,2], [0,3,6], [0,4,8], [6,7,8], [2,5,8], [1,4,7], [3,4,5], [2,4,6]]
			(0...win_win.size).each { |x| 
				checker = 0
				(0...win_win[x].size).each { |n|  
					if @collect_enemy_index.include?(win_win[x][n])
						checker += 1
					else
						last_chance = win_win[x][n] + 1
						checker -= 1 if @collect_index.include?(win_win[x][n])
					end }

				if checker == 2
					@computer_move = last_chance
					@collect_index << last_chance - 1
					made_move = true
					break
				end }

			if made_move == false
				random_move
			end

		end

		def move_tracker(positions)
			(0...positions.size).each { |x| 
				if positions[x].is_a?(String)
					@collect_enemy_index << x unless @collect_enemy_index.include?(x) || positions[x] == @sign
					@collect_index << x unless @collect_index.include?(x) || positions[x] != @sign
					@moves_already_selected << x + 1 unless @moves_already_selected.include?(x + 1)
				end }
		end

		private
		def random_move
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

