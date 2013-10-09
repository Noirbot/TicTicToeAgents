class TTTGame
	# Creates a blank board as a 2d array, ar well as all the other necessary variables.
	def initialize()
		@gameboard = [ ["", "", ""], ["", "", ""], ["", "", ""] ]
		@has_winner = false
		@winner = ''
		@to_play = 'X'
	end

	# Places a X or an O on the board.
	def self.place(x, y, mark, board)
		# Duplicates the board since strings are stored by reference.
		board = board.map {|line| line.map {|str| str.dup}}
		if board[x][y] == ''
			board[x][y] = mark
			return board
		else
			return board
		end
	end

	# Manages X's turn.
	def turn_x?(x, y)
		if not @has_winner and @to_play == 'X'
			@gameboard = TTTGame.place(x, y, 'X', @gameboard)
			@has_winner = TTTGame.won?(@gameboard)
			if @has_winner
				@winner = 'X'
			else
				@to_play = 'O'
			end
			true
		else
			false
		end
	end

	#Manages O's turn.
	def turn_o?(x, y)
		if not @has_winner and @to_play == "O"
			@gameboard = TTTGame.place(x, y, "O", @gameboard)
			@has_winner = TTTGame.won?(@gameboard)
			if @has_winner
				@winner = "O"
			else
				@to_play = "X"
			end
			return true
		else
			return false
		end
	end

	# Checks for a winner.
	def self.won?(board)
		def self.all_owned?(box1, box2, box3)
			return ([box1, box2, box3].uniq.length == 1 && box1 != "")
		end

		return all_owned?(*board[0]) ||
			   all_owned?(*board[1]) ||
			   all_owned?(*board[2]) ||
			   all_owned?(board[0][0], board[1][1], board[2][2]) ||
			   all_owned?(board[0][2], board[1][1], board[2][0]) ||
			   all_owned?(board[0][0], board[1][0], board[2][0]) ||
			   all_owned?(board[0][1], board[1][1], board[2][1]) ||
			   all_owned?(board[0][2], board[1][2], board[2][2])
	end

	# Getters.
	def gameboard
		@gameboard
	end

	def has_winner?
		@has_winner
	end

	def to_play
		@to_play
	end

	def winner
		@winner
	end

	# Returns the board as a nicely formatted string.
	def board_string
		output_string = ""
		@gameboard.each_with_index do |x, xi|
			x.each_with_index do |y, yi|
				if y == ""
					y = "-"
				end
				output_string += y
			end
			output_string += "\n"
		end
		return output_string
	end

	# Checking if the board is all full.
	def is_full?
		@gameboard.each do |x|
			x.each do |y|
				if y == ""
					return false
				end
			end
		end
		return true
	end
end
