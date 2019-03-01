GEM_HOME = '/home/tux/.gem/ruby/2.6.0'
require 'arcball'

visor_class :Arc do
  def initialize
    ArcBall.init(sketch)
  end
end

Arc.new

def draw
  background 255

  lights

  # translate width / 2, height / 2, 0

  # rotate_x frameCount * 0.01
  # rotate_y frameCount * 0.0125
  # rotate_z frameCount * 0.015

  stroke 0
  fill 255, 0, 0

  box 100
end
