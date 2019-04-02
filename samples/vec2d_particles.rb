# ===== Default : Default
$LOAD_PATH << File.expand_path('/home/sid/vecmath/lib', __FILE__)
require 'vecmath'

rectMode CENTER

visor_class :Box do
  SIZE = 80

  def initialize
    @pos = Vec2D.new(rand(width), rand(height))
    @vel = Vec2D.random * 2
  end

  def update
    @pos += @vel

    @pos.x = width + SIZE if @pos.x < -SIZE
    @pos.y = height + SIZE if @pos.y < -SIZE
    @pos.x = -SIZE if @pos.x > width + SIZE
    @pos.y = -SIZE if @pos.y > height + SIZE
  end

  def draw
    with_translate @pos.x, @pos.y do
      noStroke
      fill 255, 150, 0
      rect 0, 0, SIZE, SIZE
    end
  end
end

@boxes = []
40.times do
  @boxes << Box.new
end

def draw
  background 0

  @boxes.each do |box|
    box.update
    box.draw
  end
end
# ===== circles : circles
GEM_HOME = '/home/tux/.gem/ruby/2.6.0'
require 'vecmath'

visor_class :Circle do
  RADIUS = 50

  def initialize
    @pos = Vec2D.new(rand(width), rand(height))
  end

  def update(a)
    @pos.y += speed * a
    @pos.y = -RADIUS if @pos.y > height + RADIUS
  end

  def draw(a)
    with_translate @pos.x, @pos.y do
      scale a
      noStroke
      fill 255
      ellipse 0, 0, RADIUS, RADIUS
    end
  end
end

@circles = []
150.times do
  @circles << Circle.new
end

@speed ||= 10
set_range :@speed, 0, 30

def draw
  rectMode CORNER
  noStroke
  fill 0, 50
  rect 0, 0, width, height

  @circles.each_with_index do |circle, i|
    a = i / @circles.size.to_f

    circle.update a + 0.1
    circle.draw a + 0.1
  end
end

set_blend_mode MULTIPLY
