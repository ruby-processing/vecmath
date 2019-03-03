# ===== Default : Default
frame_rate 30

@drops_size = 20
@weight = 20
@paused = false

require 'forwardable'

# wrap the run method
module Runnable
  def run
    reject!(&:dead?)
    each(&:display)
  end
end

# Using forwardable to include enumerable methods we use
# Include runnable for a nice run abstraction
class RainDrops
  include Enumerable, Runnable
  extend Forwardable

  def_delegators(:@drops, :<<, :each, :reject!, :size)

  attr_reader :drops, :width, :height

  def initialize(width, height)
    @drops = []
    @width = width
    @height = height
  end

  def fill_up(weight)
    drops << Drop.new(rand(width), rand(height / 2) - height / 2, weight)
  end
end


visor_class :Drop do
  
  attr_reader :weight, :x, :y

  def initialize(x, y, weight = nil)
    @weight = weight || 10
    @x, @y = x, y
  end

  def render
    fill(100, 100, 200)
    no_stroke
    bezier(
      x,
      y,
      x - (weight / 2),
      y + weight,
      x + (weight / 2),
      y + weight,
      x,
      y
    )
  end

  def dead?
    @y > height
  end

  def display
    @y = y + weight
    @x = x - rand(-5..5)
    render
  end
end


def draw
  @drops ||= RainDrops.new width, height
  return if paused
  # we fill up with new drops randomly
  @drops.fill_up(@weight) while rand(@drops_size / 3) < (@drops_size - @drops.size)
  # the less drops the darker it is
  background 127 + 127 * (@drops.size / @drops_size.to_f)
  @drops.run
end
# ===== raining.rb : Default

