class Coordinate
	# Creates a coordinate pair.
	def initialize(x, y)
		@x = x
		@y = y
	end

	def x
		 @x
	end

	def y
		 @y
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  alias_method :inspect, :to_s

  def ==(other_coord)
    (other_coord.x == self.x) && (other_coord.y == self.y)
  end
end
