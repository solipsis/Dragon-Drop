require_relative 'dragon'

class Player

	attr_accessor :score
	attr_accessor :dragon

	def initialize(gameWindow, id, inputMap, shape)
		@inputMap = inputMap
		@score = 0
		@gameWindow = gameWindow
		img = Gosu::Image.new(@gameWindow, "square.png", false)
		@dragon = Dragon.new(800, 200, 50, 50, img, @gameWindow, shape)
	end

	def draw
		@dragon.draw()
	end

	def update
		@dragon.update()
	end

end