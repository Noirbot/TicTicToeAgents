require "./Coordinate.rb"

# Randomly picks a available space.
class RandomTTTPlayer
  def initialize(debug)
    @loud = debug
  end

	def choose_move(board)
    if @loud
      puts 'I\'m a random player.'
    end
		open_spots = Array.new
		board.each_with_index do |x, xi|
			x.each_with_index do |y, yi|
				if y == ''
					open_spots.push(Coordinate.new(xi, yi))
				end
			end
    end

    chosen_index = rand(open_spots.length)

    if @loud
      puts "These are the available open spots on the board: #{open_spots.inspect}\n So I pick one randomly."
      puts "I choose #{open_spots[chosen_index].to_s}"
    end
		open_spots[chosen_index]
	end
end
