class Peg

	attr_accessor :body, :shape

	INFINITY = 1.0 / 0.0


	def initialize(img, x, y, radius)

		@radius = radius
		@img = img
		@width = @radius * 2
		@height = @radius * 2

		@x_scale = @width.to_f / @img.width.to_f
		@y_scale = @height.to_f / @img.height.to_f

		@body = CP::Body.new(INFINITY, INFINITY)
		@body.velocity_func() {}

		@shape = CP::Shape::Circle.new(@body, @radius, CP::Vec2.new(0,0))
		@shape.collision_type = :peg
		@shape.e = 0.9
		@shape.u = 1.0

		warp(x, y)
	end

	def draw
		@img.draw_rot(@shape.body.p.x, @shape.body.p.y, 1, @shape.body.a.radians_to_gosu, 0.5, 0.5, @x_scale, @y_scale)
	end

	def update
		@shape.body.reset_forces
	end

	def warp(x, y)
		@shape.body.p = CP::Vec2.new(x, y)
	end
end