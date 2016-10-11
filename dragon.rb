require 'chipmunk'

class Dragon 

	attr_accessor :body, :shape

	def initialize(img)

		@width = 55
		@height = 55
		@img = img

		@x_scale = (@width.to_f / @img.width.to_f) + 0.07
		@y_scale = (@height.to_f / @img.height.to_f) + 0.07

		@body = CP::Body.new(5.0, 1000.0)
		shape_array = [CP::Vec2.new(-@width/2, -@height/2), CP::Vec2.new(-@width/2, @height/2), CP::Vec2.new(@width/2, @height/2), CP::Vec2.new(@width/2, -@height/2)]
		@shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
		@shape.collision_type = :dragon
		@shape.e = 0.9
		@shape.u = 1.0
		@body.v_limit = 300


		warp(100, 10)
	end

	def draw
		@img.draw_rot(@shape.body.p.x, @shape.body.p.y, 1, @shape.body.a.radians_to_gosu, 0.5, 0.5, @x_scale, @y_scale)
	end

	def update
		#@shape.body.a += 0.03
		maxTurn = 0.75

		if (@shape.body.w > maxTurn)
			shape.body.w = maxTurn
		end
		if (@shape.body.w < -maxTurn)
			shape.body.w = -maxTurn
		end
	end


	def warp(x, y)
		@shape.body.p = CP::Vec2.new(x, y)
	end

	def breatheFire()
		fireVec = CP::Vec2.new(0.0, -1000.0)
		fireVec = fireVec.rotate(@shape.body.rot)
		@shape.body.apply_force(fireVec, CP::Vec2.new(0,0))
	end

	def moveLeft()
		@shape.body.apply_force(CP::Vec2.new(-1000.0, 0.0), CP::Vec2.new(0,0))
	end

	def moveRight()
		@shape.body.apply_force(CP::Vec2.new(1000.0, 0.0), CP::Vec2.new(0,0))
	end



end