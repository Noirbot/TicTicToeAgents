require "./TTTGame.rb"
require "./RandomTTTPlayer.rb"
require "./SmartTTTPlayer.rb"

# Adding a method to the global String class to check if a string represents an integer.
class String
    def is_i?
       !!(self =~ /^[-+]?[0-9]+$/)
    end
end

# If there are no arguments, give help.
if ARGV.length == 0
	puts("Help!\nUsage: ruby GameDriver.rb <agent-x> <agent-o> <num_games> [--silent]\n\tValues for agent-x: 'random', 'smart'\n\tValues for agent-o: 'random', 'smart'\n\tValues for num_games: Any integer\n\t--silent will suppress additional output - boards for every move and winners for each game.")
	exit
else # If there are arguments, but they are not the ones we need/expect, give help.
	if ARGV.length > 4 or ARGV.length < 3 or (ARGV[0] != "smart" and ARGV[0] != "random") or (ARGV[1] != "smart" and ARGV[1] != "random") or !(ARGV[2].is_i? and ARGV[2].to_i > 0)
		puts("Help!\nUsage: ruby GameDriver.rb <agent-x> <agent-o> <num_games> [--silent]\n\tValues for agent-x: 'random', 'smart'\n\tValues for agent-o: 'random', 'smart'\n\tValues for num_games: Any integer\n\t--silent will suppress additional output - boards for every move and winners for each game.")
		exit
	else # Store the arguments to the correct variables.
		agent_x = ARGV[0]
		agent_o = ARGV[1]
		num_games = ARGV[2].to_i
		if ARGV.length == 4 and ARGV[3] == "--silent"
			debug = false
		else
			puts("Debug Mode Activated. I Hope You're Ready!")
			puts("Player Information:\nPlayer X is the #{agent_x} agent\nPlayer O is the #{agent_o} agent\nPlaying #{num_games} Games!")
			debug = true
		end
	end
end

# Win/loss tracking variables.
game_count = 0
x_wins = 0
cat_wins = 0

while game_count < num_games do
	# Instantiate the agents and game tracker.
	game = TTTGame.new()
	playerX = agent_x == "smart" ? SmartTTTPlayer.new("X", debug) : RandomTTTPlayer.new(debug)
	playerO = agent_o == "smart" ? SmartTTTPlayer.new('O', debug) : RandomTTTPlayer.new(debug)

	if debug
		puts "Starting Game #{game_count + 1}"
	end

	while not game.has_winner? and not game.is_full? do # As long as we need someone to move, select the correct player and have them pick a move.
		if game.to_play == "X"
			move = playerX.choose_move(game.gameboard)

			unless game.turn_x?(move.x, move.y)
				puts("Somehow, someone went on the wrong turn.")
			end
		else
			move = playerO.choose_move(game.gameboard)

			unless game.turn_o?(move.x, move.y)
				puts("Somehow, someone went on the wrong turn.")
			end
		end
		if debug
			puts("#{game.board_string}#####")
		end
	end

	# If the last move won the game for someone,
	if game.has_winner?
		if debug
			puts("The Glorious Winner of game #{game_count + 1} is #{game.winner}")
		end
		if game.winner == 'X' # We only need to track x-wins and cat games, since O-wins is everything else.
			x_wins = x_wins + 1
		end
	else # If there's not a winner, there's a tie.
		if debug
			puts("Filled board with no winner.")
		end
		cat_wins = cat_wins + 1
	end
	if debug
		puts("The Final Board Position is:")
		puts("#{game.board_string}\n")
	end
	game_count = game_count + 1
end

# Print the helpful stats.
puts("Total Game Stats\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nX:          #{x_wins} Wins\nO:          #{game_count - x_wins - cat_wins} Wins\nCat Games:  #{cat_wins}\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
