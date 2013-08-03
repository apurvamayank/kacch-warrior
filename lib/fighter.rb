require 'gosu'

class FighterWindow < Gosu::Window

 COLOR = Gosu::Color.new(110, 78, 50)
 

	def initialize
		super(1000, 700, false)
		self.caption = "Kacch Warrior"
		# @arena = Gosu::Image.new(self,"/home/webonise/Projects/GeekHours/fighter/asset/arena.jpg",true)
		@hero = Gosu::Image.new(self,"/home/webonise/Projects/GeekHours/fighter/asset/hero/battlefield_tipping_over_animation/stand_1.bmp",true)
	end

	def update
	end

	def draw
		# @arena.draw(0,0,0)
		draw_arena
		@hero.draw(0,0,0)
	end

	def draw_arena
		draw_quad(
		 0,     0,      COLOR,
     1000, 0,      COLOR,
     0,    700, COLOR,
     1000, 700, COLOR,
			0)	

	end
end

initiate_warrior = FighterWindow.new
initiate_warrior.show()