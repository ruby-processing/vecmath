# ===== Default : Default
GEM_HOME = '/home/tux/.gem/ruby/2.6.0'
require 'vecmath'
PALETTE = %w[#a11220 #884444].freeze
@group = ColorGroup.from_web_array(PALETTE)
@colors = @group.colors
rect_mode(CORNER)
no_stroke
frame_rate(1) # set the frame rate to 1 draw call per second


def draw
  background(180) # clear the screen to grey
  grid_size = 5 # rand(3..12)   # select a rand number of squares each frame
  gap = 5 # rand(5..50) # select a rand gap between each square
  # calculate the size of each square for the given number of squares and gap between them
  cellsize = (width - (grid_size + 1) * gap) / grid_size
  position = -> (count) { gap * (count + 1) + cellsize * count + rand(-5..5) }
  MathTool::grid(grid_size, grid_size) do |x, y|
    rand(0..5) > 4 ? fill(color(@colors[0]), 180.0) : fill(color(@colors[1]), 180.0)
    rect(position.call(x), position.call(y), cellsize, cellsize)
  end
end
