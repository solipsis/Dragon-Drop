require_relative 'entity'

class Dragon < Entity

	def initialize(x, y, width, height, img, gameWindow, space)
		super(x, y, width, height, img, gameWindow, space)
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
		
		#puts shape.body.w
	end

	def moveLeft
	end

	def moveRight
	end

	def respawn
	end

	def createShape()
		@body = CP::Body.new(5.0, 1000.0)
		#shape_array = [CP::Vec2.new(-@width/2, -@width/2), CP::Vec2.new(-@width/2, @width/2), CP::Vec2.new(@width/2, @width/2), CP::Vec2.new(@width/2, -@width/2)]
		shape_array = [CP::Vec2.new(-@width/2, -@width/2), CP::Vec2.new(-@width/2, @width/2), CP::Vec2.new(@width/2, @width/2), CP::Vec2.new(@width/2, -@width/2)]

		@shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
		@shape.collision_type = :dragon
		@space.add_body(body)
		@space.add_shape(shape)
	end
end