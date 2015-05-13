class Player

	attr_accessor :score
	attr_accessor :dragon
	attr_accessor :alive

	def initialize(inputMap, gameWindow)
		@inputMap = inputMap
		@gameWindow = gameWindow
		@score = 0
		img = Gosu::Image.new(@gameWindow, "square.png", false)
		@dragon = Dragon.new(img)

		@alive = false

	end

	def draw
		@dragon.draw()
	end

	def update

		# Positioning mode
		if (@alive == false)
			if @gameWindow.button_down?(@inputMap[:left]) || @gameWindow.button_down?(Gosu::KbLeft) then				
				@dragon.moveLeft()
			end
			if @gameWindow.button_down?(@inputMap[:right]) || @gameWindow.button_down?(Gosu::KbRight) then
				@dragon.moveRight()
			end
			if @gameWindow.button_down?(@inputMap[:action]) || @gameWindow.button_down?(Gosu::KbRight) then
				@alive = true
				@dragon.shape.body.v = CP::Vec2.new(@dragon.shape.body.v.x, 10.0)
				@dragon.shape.body.reset_forces()
			end

			@dragon.shape.body.p.y = 40
			@dragon.shape.body.a += 0.01
		# normal mode
		else	
			if @gameWindow.button_down?(@inputMap[:fire]) || @gameWindow.button_down?(Gosu::KbUp) then
				@dragon.breatheFire()
			end
			if @gameWindow.button_down?(@inputMap[:suicide])  then
				@alive = false
				@score -= 2
			end
		end
		@dragon.update()
	end


end