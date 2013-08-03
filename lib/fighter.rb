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
      # @hero.attack(self)
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
    @hero_direction = 'n'
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
    @hero_direction = 'w'
	end

	def turn_right(window)
    if @image_number > 7
      @image_number = 0
    end
    @hero_image = Gosu::Image.new(window,"/home/webonise/Projects/GeekHours/fighter/asset/hero/red_knight_battlefield_bitmaps/running e#{@image_number}.bmp",false)
    @image_number += 1
    @hero_direction = 'e'
	end

  def turn_down(window)
    if @image_number > 7
      @image_number = 0
    end
    @hero_image = Gosu::Image.new(window,"/home/webonise/Projects/GeekHours/fighter/asset/hero/red_knight_battlefield_bitmaps/running s#{@image_number}.bmp",false)
    @image_number += 1
    @hero_direction = 's'
  end

  def turn_up(window)
    if @image_number > 7
      @image_number = 0
    end
    @hero_image = Gosu::Image.new(window,"/home/webonise/Projects/GeekHours/fighter/asset/hero/red_knight_battlefield_bitmaps/running n#{@image_number}.bmp",false)
    @image_number += 1
    @hero_direction = 'n'
  end


	def attack(window)	
    if @image_number > 12
      @image_number = 0
    end	    
		@hero_image = Gosu::Image.new(window,"/home/webonise/Projects/GeekHours/fighter/asset/hero/red_knight_battlefield_bitmaps/attack #{@hero_direction}#{@image_number}.bmp",false)						
    @image_number += 1
	end

	def move
    @x += @vel_x
    @y += @vel_y
    @x %= 1000
    @y %= 700
  end

  def accelerate(window,direction)
  	sleep(0.1)  	
  	self.send(direction,window)  
  end

  def left_acceleration(window)
  	self.turn_left(window)
  	@x -= 1
  end

  def right_acceleration(window)
    self.turn_right(window)
  	@x += 1
  end

  def up_acceleration(window)
    self.turn_up(window)
  	@y -= 1
  end

  def down_acceleration(window)
    self.turn_down(window)
    @y += 1
  end	

  def attack_acceleration(window)
    self.attack(window)
  end

	def draw
		@hero_image.draw_rot(@x,@y,1,@angle)
	end
end

initiate_warrior = FighterWindow.new
initiate_warrior.show()