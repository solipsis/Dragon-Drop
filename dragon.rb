require_relative 'entity'

class Dragon < Entity

	def initialize(x, y, width, height, img, gameWindow)
		super(x, y, width, height, img, gameWindow)
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
		
	end

	def moveLeft
	end

	def moveRight
	end

	def respawn
	end
end