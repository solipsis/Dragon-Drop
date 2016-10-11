#real dragon drop begins here

require 'gosu'
require 'chipmunk'
require_relative 'fpscounter'
require_relative 'dragon'
require_relative 'peg'
require_relative 'player'
require_relative 'boundary'
require_relative 'scorezone'
require_relative 'emitter'
require_relative 'particle'


class GameWindow < Gosu::Window


	#***********************************************************************
	# TODO:
	# 
	# 
	#
	# 
	# => 5. dragon art
	# 
	# => 7.	fire particles
	# 
	#***********************************************************************

	def initialize
		super 1280, 800, false
		self.caption = "Dragon Drop"
		@fpscounter = FPSCounter.new(self)
		@mouseViewer = MouseViewer.new(self)
		@cursor = MouseCursor.new(self)
		@scoreBoard = Gosu::Font.new(self, Gosu::default_font_name, 50) 


		@particle_img = Gosu::Image.new(self, "verySmallCircle.png", false)
		@emitter = Emitter.new(-2000, 200, @particle_img)


		@playerImg1 = Gosu::Image.new(self, "a12.png")
		@playerImg2 = Gosu::Image.new(self, "a1.png")

		@pegImg = Gosu::Image.new(self, "bullet1.png", false)
		#@peg = Peg.new(pegImg)

		@background = Gosu::Image.new(self, "bullet2.png", false)
		@boundaryImg = Gosu::Image.new(self, "square.png", false)
		@scoreImg = Gosu::Image.new(self, "bullet2.png", false)

		@space = CP::Space.new
		@space.gravity = CP::Vec2.new(0.0, 50.0)

		# TODO: lazy hack ass code
		@space.add_collision_func(:dragon, :scorezone) do |a, b|
			
			score = -1
			@scorezones.each do |scorezone|
				if (scorezone.shape == b)
					if (scorezone.active == true)
						scorezone.active = false;
						score = 3
						changeActiveScorezone()
					end
				end
			end

 			if (a == @players.at(0).dragon.shape)
 				@players.at(0).alive = false
 				@players.at(0).deathEmitter = true
 				@players.at(0).score += score
 			else
 				@players.at(1).alive = false
 				@players.at(1).deathEmitter = true
 				@players.at(1).score += score
 			end
		end

		@players = Array.new()
		@boundaries = Array.new()
		@pegs = Array.new()
		@scorezones = Array.new()

		@player1_controls = {
			:up => Gosu::Gp0Up,
			:down => Gosu::Gp0Down,
			:left => Gosu::Gp0Left,
			:right => Gosu::Gp0Right,
			:fire => Gosu::Gp0Button2,
			:action => Gosu::Gp0Button0,
			:suicide => Gosu::Gp0Button3,
		}
		@player2_controls = {
			:up => Gosu::Gp1Up,
			:down => Gosu::Gp1Down,
			:left => Gosu::Gp1Left,
			:right => Gosu::Gp1Right,
			:fire => Gosu::Gp1Button2,
			:action => Gosu::Gp1Button0,
			:suicide => Gosu::Gp1Button3,
		}

		@players.push(Player.new(@player1_controls, self, @playerImg1))
		@players.push(Player.new(@player2_controls, self, @playerImg2))
		
		@players.at(1).dragon.warp(400, 10) # position player 2

		@players.each do |player|
			addPhysicsObject(player.dragon.body, player.dragon.shape)
		end

		createBoundaries()
		createPegs()
		createScoreZones()
		changeActiveScorezone()

		@boundaries.each do |boundary|
			addPhysicsObject(boundary.body, boundary.shape)
		end

		@pegs.each do |peg|
			addPhysicsObject(peg.body, peg.shape)
		end

		@scorezones.each do |scorezone|
			addPhysicsObject(scorezone.body, scorezone.shape)
		end


		
		#addPhysicsObject(@peg.body, @peg.shape)
	end


	def update
		@fpscounter.update

		@players.each do |player|
			player.update
		end
	
		@space.step(1.0/60.0)

		@players.each do |player|
			player.dragon.shape.body.reset_forces()
		end
		
		@emitter.update
	end


	def draw
		@background.draw_rot(0, 0, 1, 0, 0.5, 0.5, 300, 300)
		@scoreBoard.draw("      " + @players.at(0).score.to_s + "                                                                                     " + @players.at(1).score.to_s, 10, 10, 40) 
		@fpscounter.draw
		
		@players.each do |player|
			player.draw
		end

		@boundaries.each do |boundary|
			boundary.draw
		end
		
		@pegs.each do |peg|
			peg.draw
		end

		@scorezones.each do |scorezone|
			scorezone.draw
		end

		@mouseViewer.draw()
		@cursor.draw(self.mouse_x, self.mouse_y)
		
		@emitter.draw
	end

	def addPhysicsObject(body, shape)
		@space.add_body(body)
		@space.add_shape(shape)
	end

	def createBoundaries()
		size = 80
		for x in 0..15 do
			@boundaries.push(Boundary.new(@boundaryImg, (x * size) + (size/2), 1200, size))
			@boundaries.push(Boundary.new(@boundaryImg, (x * size) + (size/2), -100, size))
		end

		for y in 0..15 do
			@boundaries.push(Boundary.new(@boundaryImg, size/2, (y * size) + (size/2), size))
			@boundaries.push(Boundary.new(@boundaryImg, (size/2) + 1200, (y * size) + (size/2), size))
		end

		size = 20
		for x in 0..3 do
			for y in 0..25 do
				@boundaries.push(Boundary.new(@boundaryImg, (x * 250) + 270, (y*size) + 750, size))
				#@boundaries.push(Boundary.new(@boundaryImg, (x * size) + (size/2), -100, size))
			end
		end
	end

	def changeActiveScorezone()
		@scorezones.shuffle!
		@scorezones.at(0).active = true
	end

	def createPegs()
		#Struct.new("PegData", :x, :y, :radius)
		@pegs.push(Peg.new(@pegImg, 400, 300, 20))
		#@pegs.push(Peg.new(@pegImg, 200, 500, 80))
		@pegs.push(Peg.new(@pegImg, 720, 290, 50))
		#@pegs.push(Peg.new(@pegImg, 200, 700, 40))
		@pegs.push(Peg.new(@pegImg, 600, 200, 10))
		@pegs.push(Peg.new(@pegImg, 700, 600, 30))
		@pegs.push(Peg.new(@pegImg, 500, 500, 30))


		#left side
		@pegs.push(Peg.new(@pegImg, 106, 238, 20))
		@pegs.push(Peg.new(@pegImg, 206, 304, 20))
		@pegs.push(Peg.new(@pegImg, 277, 206, 20))
		@pegs.push(Peg.new(@pegImg, 522, 301, 20))
		@pegs.push(Peg.new(@pegImg, 323, 439, 20))
		@pegs.push(Peg.new(@pegImg, 380, 561, 20))
		
		@pegs.push(Peg.new(@pegImg, 451, 142, 20))
		@pegs.push(Peg.new(@pegImg, 100, 398, 20))
		@pegs.push(Peg.new(@pegImg, 200, 517, 20))
		@pegs.push(Peg.new(@pegImg, 100, 637, 20))
		@pegs.push(Peg.new(@pegImg, 258, 703, 20))

		#right side
		@pegs.push(Peg.new(@pegImg, 510, 680, 20))
		@pegs.push(Peg.new(@pegImg, 590, 406, 20))
		@pegs.push(Peg.new(@pegImg, 840, 493, 20))
		 
		@pegs.push(Peg.new(@pegImg, 880, 662, 20))
		@pegs.push(Peg.new(@pegImg, 970, 200, 20))
		@pegs.push(Peg.new(@pegImg, 1140, 287, 20))
		@pegs.push(Peg.new(@pegImg, 1050, 480, 20))

		@pegs.push(Peg.new(@pegImg, 705, 452, 20))
		@pegs.push(Peg.new(@pegImg, 890, 336, 20))
		@pegs.push(Peg.new(@pegImg, 1030, 355, 20))
		@pegs.push(Peg.new(@pegImg, 1170, 600, 20))
		@pegs.push(Peg.new(@pegImg, 1010, 705, 20))
		@pegs.push(Peg.new(@pegImg, 807, 144, 20))

	end

	def createScoreZones()
		@scorezones.push(Scorezone.new(@scoreImg, 150, 1000, 100, 100))
		@scorezones.push(Scorezone.new(@scoreImg, 400, 1000, 100, 100))
		@scorezones.push(Scorezone.new(@scoreImg, 650, 1000, 100, 100))
		@scorezones.push(Scorezone.new(@scoreImg, 900, 1000, 100, 100))
		@scorezones.push(Scorezone.new(@scoreImg, 1120, 1000, 100, 100))

	end
end

class CollisionHandler
  def begin(a, b, arbiter)
  	puts a
  	puts b
  end
  
  def pre_solve(a, b)
  end
  
  def post_solve(arbiter)
  end
  
  def separate
  end
end


class MouseCursor
	def initialize(window)
		@img = Gosu::Image.new(window, "circle_icon.png", false)
		@delta_x = 0
		@delta_y = 0
		@prev_x = 0
		@prev_y = 0
	end

	def draw(x, y)
		@delta_x = (x - @prev_x) * 0.5
		@delta_y = (y - @prev_y) * 0.5
		@prev_x = x
		@prev_y = y
		@img.draw(x + @delta_x - 10, y + @delta_y - 10, 0)
		#@img.draw(x - 10,y - 10, 1)
	end
end

GameWindow.new.show()