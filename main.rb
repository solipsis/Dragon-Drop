require 'gosu'
require 'chipmunk'
require_relative 'fpscounter'
require_relative 'player'
require_relative 'entity'
require_relative 'peg'

class GameWindow < Gosu::Window

	INFINITY = 1.0 / 0.0
	SUBSTEPS = 6

	def initialize
		super 1280, 800, false
		self.caption = "Dragon Drop"
		@fpscounter = FPSCounter.new(self)
		@players = Array.new()
		@pegs = Array.new()
		@pegImg = Gosu::Image.new(self, "bullet1.png", false ) 

		@player1_controls = {
			:up => Gosu::Gp0Up,
			:down => Gosu::Gp0Down,
			:left => Gosu::Gp0Left,
			:right => Gosu::Gp0Right,
			:t1 => Gosu::Gp0Button2,
			:t2 => Gosu::Gp0Button3,
			:t3 => Gosu::Gp0Button1,
			:record => Gosu::Gp0Button0,
			:debug => Gosu::Gp0Button4
		}

		@background = Gosu::Image.new(self, "bullet2.png", false)
		#@player1 = Player.new(self, 1, @player1_controls)
		#@players.push(@player1)
		addPhysicsElements()
		#addPlayerBodies()

		#@pegs.push(Peg.new(200,200, 30, 30, pegImg, self ))

		#@space = CP::Space.new
		#@space.damping = 0.8
		#@space.add_body(@player1.dragon.body)
		#@space.add_shape(@player1.dragon.shape)
		#@space.gravity = CP::Vec2.new(0.0, 50.0)
	end

	def update
		@fpscounter.update()
		@players.each do |player|
			player.update()
		end
		#SUBSTEPS.times do 
			#@player1.dragon.shape.body.reset_forces
			@space.step(1.0/60.0)
		#end
	end

	def draw
		@background.draw_rot(0, 0, 1, 0, 0.5, 0.5, 300, 300)
		@fpscounter.draw()
		@players.each do |player|
			player.draw()
			#puts @player1.dragon.shape.body.p.x
			#puts @player1.dragon.shape.body.p.y
		end
		@pegs.each do |peg|
			peg.draw()
			#puts peg.shape.body.p.x
			#puts peg.shape.body.p.y
		end
	end

	def addPhysicsElements
		@space = CP::Space.new
		# puts @space.public_methods
		@space.gravity = CP::Vec2.new(0.0, 100.0)
		addPlayerBodies()
		addPegBodies()		
	end

	def addPlayerBodies
		@player1 = Player.new(self, 1, @player1_controls, @space)
		@players.push(@player1)

	end

	def addPegBodies
		#shape = createPegBody
		#peg = Peg.new(805,600, 100, 100, @pegImg, self, @space )
	#	@pegs.push(peg)
		@pegs.push(makePeg(805, 600, 50))
		@pegs.push(makePeg(500,600, 60))
		@pegs.push(makePeg(870, 500, 40))
		@pegs.push(makePeg(850, 400, 50))
		#@space.rehash_shape(shape)

	end

	def makePeg(x, y, radius)
		return Peg.new(x, y, radius*2, radius*2, @pegImg, self, @space)
	end

	# def createDragonBody
	# 	body = CP::Body.new(5.0, 1000.0)
	# 	shape_array = [CP::Vec2.new(-100.0, -100.0), CP::Vec2.new(-100.0, 100.0), CP::Vec2.new(100.0, 100.0), CP::Vec2.new(100.0, -100.0)]
	# 	shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
	# 	shape.collision_type = :dragon
	# 	@space.add_body(body)
	# 	@space.add_shape(shape)

	# 	return shape	
	# end

	def createPegBody
		# body = CP::StaticBody.new
		# shape_array = [CP::Vec2.new(0, 400), CP::Vec2.new(900, 400), CP::Vec2.new(900, 390), CP::Vec2.new(0, 390)]
		# #shape = CP::Shape::Circle.new(body, 100, CP::Vec2.new(0,0))
		
		# shape_array = [CP::Vec2.new(0, 600), CP::Vec2.new(800, 600), CP::Vec2.new(800, 590), CP::Vec2.new(0, 590)]
		# shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
		# shape.collision_type = :floor
		# @space.add_shape(shape)



		body = CP::Body.new(INFINITY, INFINITY)
		body.velocity_func() { 

		}
		shape = CP::Shape::Circle.new(body, 60, CP::Vec2.new(0,0))
		#shape_array = [CP::Vec2.new(-50.0, -50.0), CP::Vec2.new(-50.0, 50.0), CP::Vec2.new(50.0, 50.0), CP::Vec2.new(50.0, -50.0)]
		#shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
		shape.collision_type = :peg
		@space.add_body(body)
		@space.add_shape(shape)

		return shape
	end



end

GameWindow.new.show()