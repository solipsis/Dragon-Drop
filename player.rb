class Player

	attr_accessor :score
	attr_accessor :dragon
	attr_accessor :alive
	attr_accessor :deathEmitter

	def initialize(inputMap, gameWindow)
		@inputMap = inputMap
		@gameWindow = gameWindow
		@score = 0
		img = Gosu::Image.new(@gameWindow, "square.png", false)
		@dragon = Dragon.new(img)

		@alive = false

		@particle_img = Gosu::Image.new(@gameWindow, "verySmallCircle.png", false)
		@emitter = Emitter.new(-5000, 0, @particle_img)

		@breathingFire = false



		@fireEmitter = Emitter.new(-4000, 0, @particle_img) do 
			self.emissionRate = 1
			self.life = 30
			self.alphaDecayRate = 3
			self.green = 0
			self.blue = 0
			self.greenVariance = 50
			self.blueVariance = 50
			self.totalParticles = 200
			self.angleVariance = 50
		end



		@deathEmitter = false

		@deathTimer = 70

		@fireTimer = 0

	end

	def draw
		@dragon.draw()
		if @deathTimer < 100
			@emitter.draw()
		end
		if @breathingFire || @fireTimer < 40
			@fireEmitter.draw()
		end
	end

	def update
		
		
		@deathTimer += 1
		@fireTimer += 1
		
		
		@fireEmitter.update()

		if @fireTimer > 1
			@fireEmitter.disableSpawns = true
		end
		@emitter.update()
		

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

			if (@deathEmitter == true)
				@deathTimer = 0
				@deathEmitter = false
				@emitter = Emitter.new(@dragon.shape.body.p.x, @dragon.shape.body.p.y, @particle_img)
			end

		# normal mode
		else
			@breathingFire = false	
			if @gameWindow.button_down?(@inputMap[:fire]) || @gameWindow.button_down?(Gosu::KbUp) then
				@dragon.breatheFire()
				@breathingFire = true
				@fireEmitter.x = @dragon.shape.body.p.x - 10
				@fireEmitter.y = @dragon.shape.body.p.y - 10
				@fireTimer = 0
				@fireEmitter.disableSpawns = false
				@fireEmitter.angle = @dragon.shape.body.a.radians_to_gosu
				#puts @dragon.shape.body.a.radians_to_gosu
			end
			if @gameWindow.button_down?(@inputMap[:suicide])  then
				@alive = false
				@score -= 2
			end
		end
		@dragon.update()
	end


end