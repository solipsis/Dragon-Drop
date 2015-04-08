class Peg < Entity

	def initialize(x, y, width, height, img, gameWindow, shape)
		super(x, y, width, height, img, gameWindow, shape)
	end

	def draw
		super()
	end

	def update
		super()
		@shape.body.reset_forces
	end
end