require 'gosu'

class FighterWindow < Gosu::Window

 COLOR = Gosu::Color.new(110, 78, 50)
 

	def initialize
		super(1000, 700, false)
		self.caption = "Kacch Warrior"		
		@hero = Hero.new(self)
		@hero.warp(320, 120)
	end

	def update
		if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      # @hero.turn_left(self)
      @hero.accelerate(self,"left_acceleration")
    end

    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @hero.turn_right(self)
      @hero.accelerate(window,"right_acceleration")
    end

    if button_down? Gosu::KbSpace  then    	
      @hero.attack(self)
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
     1000, 0,   COLOR,
     0,    700, COLOR,
     1000, 700, COLOR,
			0)
	end

	def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end


class Hero
	def initialize(window)
		@hero_image = Gosu::Image.new(window,"/home/webonise/Projects/GeekHours/fighter/asset/hero/red_knight_battlefield_bitmaps/paused e0000.bmp",false)
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@image_number = 0
	end

	def warp(x, y)
    @x, @y = x, y
  end

	def turn_left(window)		
		if @image_number > 7
			@image_number = 0
		end
    @hero_image = Gosu::Image.new(window,"/home/webonise/Projects/GeekHours/fighter/asset/hero/red_knight_battlefield_bitmaps/running w#{@image_number}.bmp",false)
    @image_number += 1
	end

	def turn_right(window)
		 @angle += 0
     @hero_image = Gosu::Image.new(window,"/home/webonise/Projects/GeekHours/fighter/asset/hero/red_knight_battlefield_bitmaps/right.bmp",false)
	end


	def attack(window)		
			@hero_image = Gosu::Image.new(window,"/home/webonise/Projects/GeekHours/fighter/asset/hero/red_knight_battlefield_bitmaps/attack e0000.bmp",false)						
	end

	def move
    @x += @vel_x
    @y += @vel_y
    @x %= 1000
    @y %= 700
    
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def accelerate(window,direction)
  	sleep(0.04)  	
  	self.send(direction,window)  
  end

  def left_acceleration(window)
  	self.turn_left(window)
  	@x -= 1
  end

  def right_acceleration
  	@x += 1
  end

  def up_acceleration
  	@y += 1
  end

  def down_acceleration
    @y -= 1
  end	

	def draw
		@hero_image.draw_rot(@x,@y,1,@angle)
	end
end

initiate_warrior = FighterWindow.new
initiate_warrior.show()