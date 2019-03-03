# ===== Default : Default
GEM_HOME = '/home/tux/.gem/ruby/2.6.0'
require 'vecmath'
require 'forwardable'

# Here we use the JRubyArt Vec2D class, and GfxRender class (for vec.to_vertex)
# Further we use the power of ruby (metaprogramming) to make Branch enumerable
# and use Forwardable to define which enumerable methods we want to use.
visor_class :Branch do
  include Enumerable
  extend Forwardable
  def_delegators(:@children, :<<, :each, :length)
  # variance angle for growth direction per time step
  THETA = Math::PI / 6
  # max segments per branch
  MAX_LEN = 100
  # max recursion limit
  MAX_GEN = 3
  # branch chance per time step
  BRANCH_CHANCE = 0.05
  # branch angle variance
  BRANCH_THETA = Math::PI / 3
  attr_reader :position, :dir, :path, :children, :xbound, :speed, :ybound, :app

  def initialize(pos, dir, speed)
    @renderer ||= GfxRender.new(graphics)
    @position = pos
    @dir = dir
    @speed = speed
    @path = []
    @children = []
    @xbound = Boundary.new(0, width)
    @ybound = Boundary.new(0, height)
    path << pos
  end

  def run
    grow
    display
  end

  private

  # NB: use of both rotate! (changes original) rotate (returns a copy) of Vec2D
  def grow
    check_bounds(position + (dir * speed)) if path.length < MAX_LEN
    @position += (dir * speed)
    dir.rotate!(rand(-0.5..0.5) * THETA)
    path << position
    if (length < MAX_GEN) && (rand < BRANCH_CHANCE)
      branch_dir = dir.rotate(rand(-0.5..0.5) * BRANCH_THETA)
      self << Branch.new(position.copy, branch_dir, speed * 0.99)
    end
    each(&:grow)
  end

  def display
    begin_shape
    stroke(255)
    no_fill
    path.each { |vec| vec.to_vertex(@renderer) }
    end_shape
    each(&:display)
  end

  def check_bounds(pos)
    dir.x *= -1 if xbound.exclude? pos.x
    dir.y *= -1 if ybound.exclude? pos.y
  end
end

# we are looking for excluded values
Boundary = Struct.new(:lower, :upper) do
  def exclude?(val)
    !(lower...upper).cover? val
  end
end

@root = Branch.new(
    Vec2D.new(0, height / 2),
    Vec2D.new(1, 0),
    10.0
)

def draw
  background(0)
  root.run
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
