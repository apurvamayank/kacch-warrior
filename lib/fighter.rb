require 'gosu'
load "lib/hero.rb"

class FighterWindow < Gosu::Window

 COLOR = Gosu::Color.new(113, 78, 50) 

	def initialize
		super(1200, 700, false)
		self.caption = "Kacch Warrior"		
		@hero = Hero.new(self)
		@hero.hero_warp(320, 120)
    @hero.monster_wrap(500, 120)
	end

	def update
		if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @hero.accelerate(self,"left_acceleration")
    end

    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @hero.accelerate(self,"right_acceleration")
    end

    if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
      @hero.accelerate(self,"down_acceleration")
    end

    if button_down? Gosu::KbUp or button_down? Gosu::GpUp then
      @hero.accelerate(self,"up_acceleration")
    end

    if button_down? Gosu::KbSpace  then
      @hero.accelerate(self,"attack_acceleration")
    end

    @hero.move
    end


	def draw
		draw_arena
		@hero.draw
	end

	def draw_arena
		draw_quad(
		 0,    0,   COLOR,
     1200, 0,   COLOR,
     0,    700, COLOR,
     1200, 700, COLOR,
			0)
	end

	def button_down(id)
    if id == Gosu::KbEscape
      close                                                 
    end
  end
end

initiate_warrior = FighterWindow.new
initiate_warrior.show()