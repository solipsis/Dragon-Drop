class Peg < Entity

	INFINITY = 1.0 / 0.0

	def initialize(x, y, width, height, img, gameWindow, space)
		super(x, y, width, height, img, gameWindow, space)
		@x_scale = @width.to_f / @img.width.to_f
		@y_scale = @height.to_f / @img.height.to_f
	end

	def draw
		@img.draw_rot(@shape.body.p.x, @shape.body.p.y, 1, @shape.body.a.radians_to_gosu, 0.5, 0.5, @x_scale, @y_scale)
	end

	def update
		super()
		@shape.body.reset_forces
	end

	def createShape
		body = CP::Body.new(INFINITY, INFINITY)
		body.velocity_func() { 

		}
		@shape = CP::Shape::Circle.new(body, @width/2, CP::Vec2.new(0,0))
		@shape.collision_type = :peg
		@space.add_body(body)
		@space.add_shape(shape)
	end
end