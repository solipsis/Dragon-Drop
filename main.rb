require 'gosu'
require 'chipmunk'
require_relative 'fpscounter'
require_relative 'player'
require_relative 'entity'
require_relative 'peg'

class GameWindow < Gosu::Window

	def initialize
		super 1280, 800, false
		self.caption = "Dragon Drop"
		@fpscounter = FPSCounter.new(self)
		@players = Array.new()
		@pegs = Array.new()
		pegImg = Gosu::Image.new(self, "bullet1.png", false ) 

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
		@player1 = Player.new(self, 1, @player1_controls)
		@players.push(@player1)

		@pegs.push(Peg.new(200,200, 30, 30, pegImg, self ))

		@space = CP::Space.new
		#@space.damping = 0.8
		@space.add_body(@player1.dragon.body)
		@space.add_shape(@player1.dragon.shape)
		@space.gravity = CP::Vec2.new(0.0, 50.0)
	end

	def update
		@fpscounter.update()
		@players.each do |player|
			player.update()
		end
		@space.step(1.0/60.0)
	end

	def draw
		@fpscounter.draw()
		@players.each do |player|
			player.draw()
		end
		@pegs.each do |peg|
			peg.draw()
		end
	end

end

GameWindow.new.show()