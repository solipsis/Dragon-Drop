require 'chipmunk'


class Numeric
  def radians_to_vec2
    CP::Vec2.new(Math::cos(self), Math::sin(self))
  end
end


class Entity

	attr_accessor :x, :y, :width, :height
	attr_accessor :body
	attr_accessor :shape


	def initialize(x, y, width, height, img, gameWindow, space)
		@x = x
		@y = y
		@width = width
		@height = height
		@img = img
		@gameWindow = gameWindow
		#@x_scale = @width.to_f / @img.width.to_f
		#@y_scale = @height.to_f / @img.height.to_f
		@x_scale = 1
		@y_scale = 1
		@space = space

		createShape()


		warp(@x, @y)
		#@shape.body.p = CP::Vec2.new(0, 200)
		@shape.body.v = CP::Vec2.new(0.0, 0.0)

		@shape.body.a = (3*Math::PI/2.0)
		@shape.e = 0.9
		# chipmunk stuff
		#@body = CP::Body.new(10.0, 50.0)
		#shape_array = [CP::Vec2.new(-25.0, -25.0), CP::Vec2.new(-25.0, 25.0), CP::Vec2.new(25.0, 1.0), CP::Vec2.new(25.0, -1.0)]
    	#@shape = CP::Shape::Poly.new(@body, shape_array, CP::Vec2.new(0,0))
		#@shape.body.p = CP::Vec2.new(@x, @y) # position
		#@shape.body.v = CP::Vec2.new(1.0, 1.0) # velocity
		#@shape.body.a = (3*Math::PI/2.0) # angle in radians
	end

	def warp(x, y)
		@shape.body.p = CP::Vec2.new(x, y)
	end

	def draw
		#puts @shape.body.p.x
		#puts @shape.body.p.y
		@img.draw_rot(@shape.body.p.x, @shape.body.p.y, 1, @shape.body.a.radians_to_gosu, 0.5, 0.5, @x_scale, @y_scale)
	end

	def update
		#@shape.body.apply_force((@shape.body.a.radians_to_vec2 * (3000.0)), CP::Vec2.new(50.0, 50.0))
	end

	# only applies to not rotated entities
	def intersects?
		return (@x <= (e2.x + e2.width) &&
				e2.x <= (@x + @width) &&
				@y <= (e2.y + e2.height) &&
				e2.y <= (@y + @height)
		)
	end

	def addCollisionShape

	end

	def createShape()

	end
end