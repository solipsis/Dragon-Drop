class Scorezone

	attr_accessor :body, :shape, :score, :active

	INFINITY = 1.0 / 0.0


	def initialize(img, x, y, size, score)
		@img = img
		@width = size
		@height = size
		@score = score
		@active = false

		@x_scale = @width.to_f / @img.width.to_f
		@y_scale = @height.to_f / @img.height.to_f

		@body = CP::Body.new(INFINITY, INFINITY)
		@body.velocity_func() {}

		shape_array = [CP::Vec2.new(-@width/2, -@height/2), CP::Vec2.new(-@width/2, @height/2), CP::Vec2.new(@width/2, @height/2), CP::Vec2.new(@width/2, -@height/2)]
		@shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
		@shape.collision_type = :scorezone
		@shape.e = 0.0
		@shape.u = 1.0

		warp(x, y)
	end

	def draw
		if (@active)
			@img.draw_rot(@shape.body.p.x,800, 1, @shape.body.a.radians_to_gosu, 0.5, 0.5,@x_scale, @y_scale)

		else
			@img.draw_rot(@shape.body.p.x, @shape.body.p.y, 1, @shape.body.a.radians_to_gosu, 0.5, 0.5, @x_scale, @y_scale)
		end
	end

	def update
		@shape.body.reset_forces
	end

	def warp(x, y)
		@shape.body.p = CP::Vec2.new(x, y)
	end
end