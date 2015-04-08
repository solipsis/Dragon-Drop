require_relative 'entity'

class Dragon < Entity

	def initialize(x, y, width, height, img, gameWindow, shape)
		super(x, y, width, height, img, gameWindow, shape)
		#@gameWindow = gameWindow
		#@img = img
		#@x = 0
		#@y = 0
		@fireTimer = 300
	end

	def draw
		super()
	end

	def update
		if (shape.body.w > 1.0)
			shape.body.w = 1.0
		end
		if (shape.body.w < -1.0)
			shape.body.w = -1.0
		end
		super()
		
		puts shape.body.w
	end

	def moveLeft
	end

	def moveRight
	end

	def respawn
	end
end