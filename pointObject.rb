class PointObject < Entity

	def initialize(x, y, width, height, img, gameWindow)
		super(x, y, width, height, img, gameWindow)

		@pointValue = 50
	end

	def draw
		super()
	end


end 