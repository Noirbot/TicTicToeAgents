require "./Coordinate.rb"
require "./TTTGame.rb"

class SmartTTTPlayer
	# Set up and make note of what player we are.
	def initialize(mark, debug)
		@mark = mark
		@opp_mark = @mark == 'X' ? 'O' : 'X'
    @loud = debug
	end

	# Finds all of the open spaces on the current board and returns them as an array.
	def get_open_spaces(board)
		open_spots = Array.new
		board.each_with_index do |x, xi|
			x.each_with_index do |y, yi|
				if y == ""
					open_spots.push(Coordinate.new(xi, yi))
				end
			end
		end
		open_spots
	end

	# Picks a move, looking for a way to win first, then a way to block the opponent from winning, and if neither exists, picks randomly.
	def choose_move(board)
		possible_moves = get_open_spaces(board)
    if @loud
      puts "As a smart player, I will look at all available spaces: #{possible_moves.inspect}"
    end

		my_boards = possible_moves.map { |move|  TTTGame.place(move.x, move.y, @mark, board) } # Every board that exists after I move.
		their_boards = possible_moves.map { |move|  TTTGame.place(move.x, move.y, @opp_mark, board) } # Every board that would exist if my opponent moved next.

    if @loud
      puts 'Then, since I know all of our possible moves, I can generate the future boards for myself and my opponent, after this turn.'
      puts 'Check all of the boards that could exist after I move to see if I can win.'
    end

		my_boards.each_with_index do |b, bi|
			if TTTGame.won?(b)
        if @loud
          puts "I can win by moving to #{possible_moves[bi].to_s}"
        end
				return possible_moves[bi]
			end
		end

    if @loud
      puts 'Check all of the boards that could exist if my opponent moved to see if I can prevent him winning.'
    end

		their_boards.each_with_index do |b, bi|
			if TTTGame.won?(b)
        if @loud
          puts "I can prevent #{@opp_mark} from winning by moving to #{possible_moves[bi].to_s}"
        end
				return possible_moves[bi]
			end
		end

    if @loud
      puts 'There are no win conditions for either player, so we choose a space from the open ones.'
    end

    center_space = Coordinate.new(1, 1)

    if possible_moves.include?(center_space)
      if @loud
        puts 'The center space is available and is generally optimal to choose! I take it.'
      end
      return center_space
    end

    chosen_space = rand(possible_moves.length)
    if @loud
      puts "The center space is taken, so we just pick another space randomly: #{possible_moves[chosen_space]}."
    end
		possible_moves[chosen_space]
	end
end
