class Hero
	def initialize(window)
		@hero_image = Gosu::Image.new(window,"./asset/hero/red_knight_battlefield_bitmaps/paused e0000.bmp",false)
    @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_bitmaps/attack w0.bmp",false)
    @queen_image = Gosu::Image.new(window,"./asset/queen/talking-e0.png",false)
    @hero_direction = 'n'
    @monster_direction = 'n'
		@x = @y = @m_x = @m_y = @vel_x = @vel_y = @angle = 0.0
		@image_number = 0
    @die_image = 0
    @queen_number = 0
    @score = 0
	end

	def hero_warp(x, y)
    @x, @y = x, y
  end

  def monster_wrap(x,y)
    @m_x = x
    @m_y = y
  end

	def turn_left(window)		
		if @image_number > 7
			@image_number = 0
		end
    @hero_image = Gosu::Image.new(window,"./asset/hero/red_knight_battlefield_bitmaps/running w#{@image_number}.bmp",false)
    @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_bitmaps/running w#{@image_number}.bmp",false)
    @image_number += 1
    @hero_direction = 'w'
    @monster_direction = 'w'
	end

	def turn_right(window)
    if @image_number > 7
      @image_number = 0
    end
    @hero_image = Gosu::Image.new(window,"./asset/hero/red_knight_battlefield_bitmaps/running e#{@image_number}.bmp",false)
    @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_bitmaps/running w#{@image_number}.bmp",false)
    @image_number += 1
    @hero_direction = 'e'
	end

  def turn_down(window)
    if @image_number > 7
      @image_number = 0
    end
    @hero_image = Gosu::Image.new(window,"./asset/hero/red_knight_battlefield_bitmaps/running s#{@image_number}.bmp",false)
    @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_bitmaps/running s#{@image_number}.bmp",false)
    @image_number += 1
    @hero_direction = 's'
  end
  
  def turn_up(window)
    if @image_number > 7
      @image_number = 0
    end
    @hero_image = Gosu::Image.new(window,"./asset/hero/red_knight_battlefield_bitmaps/running n#{@image_number}.bmp",false)
    @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_bitmaps/running n#{@image_number}.bmp",false)
    @image_number += 1
    @hero_direction = 'n'
  end


	def attack(window)	    
    if @image_number > 12
      @image_number = 0
    end
    
		@hero_image = Gosu::Image.new(window,"./asset/hero/red_knight_battlefield_bitmaps/attack #{@hero_direction}#{@image_number}.bmp",false)
    if @score < 100
      @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_bitmaps/attack #{@monster_direction}#{@image_number}.bmp",false)
    else      
      if @queen_number > 7
        @queen_number = 0
      end
      @m_x += 10
      @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_tipping_over/tipping over #{@monster_direction}8.bmp",false)
      @queen_image = Gosu::Image.new(window,"./asset/queen/talking-e#{@queen_number}.png",false)
      @queen_number += 1
    end
    @image_number += 1
    
    puts @score
    if (@x - @m_x).abs >= 72 &&  (@x - @m_x).abs <= 78     
        if @score == 100 && @die_image <  8
         # self.monster_die(window)
         # @m_x += 8
         # @x -= 8
         @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_tipping_over/tipping over #{@monster_direction}#{@die_image}.bmp",false)
         @die_image += 1
          # @score = 0      
        else
          @score += 2
        end  
      else
       # @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_bitmaps/attack #{@monster_direction}#{@image_number}.bmp",false)
       # @image_number += 1  
    end
	end

  # def monster_die(window)
  #   8.times do |image_number|
  #     puts @score
  #     sleep(0.1)
  #     @m_x += 10     
  #     @monster_image = Gosu::Image.new(window,"./asset/monster/blueknight_battlefield_tipping_over/tipping over #{@monster_direction}#{@image_number}.bmp",false)
  #   end
  # end

	def move
    @x += @vel_x
    @y += @vel_y
    @x %= 1200
    @y %= 700
    @m_x %= 1200
    @m_y %= 700
  end

  def accelerate(window,direction)
  	sleep(0.1)  	
  	self.send(direction,window)  
  end

  def left_acceleration(window)
  	self.turn_left(window)
    if (@x - @m_x).abs >= 72 &&  (@x - @m_x).abs <= 78
       @x -= 3
    else
  	  @x -= 3
      @m_x -= 4
    end
  end

  def right_acceleration(window)
    self.turn_right(window)
    if (@x - @m_x).abs >= 72 &&  (@x - @m_x).abs <= 78
  	  @x -= 3
    else
      @x +=3
    end    
  end

  def up_acceleration(window)
    self.turn_up(window)
  	@y -= 3
    @m_y -= 3
  end

  def down_acceleration(window)
    self.turn_down(window)
    @y += 3
    @m_y +=3
  end	

  def attack_acceleration(window)
    self.attack(window)
  end

	def draw
		@hero_image.draw_rot(@x,@y,1,@angle)
    @monster_image.draw_rot(@m_x, @m_y, 1, @angle)
    if @score >= 100
      @queen_image.draw_rot(@x, @y + 100, 1, @angle)
    end
	end
end