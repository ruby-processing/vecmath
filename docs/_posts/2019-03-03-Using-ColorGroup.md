---
layout: post
title:  "Using ColorGroup"
date:   2019-03-03 00:50:08 +0000
categories: vecmath update
---

# Example Usage

ColorGroup can be initialized directly with and array of signed ints (corresponding to color integer), or indirectly from an array of "web string" as below.
The order can be shuffled using `:shuffle!`. The colors are obtained by calling `:colors` on the group. 

```ruby
GEM_HOME = '/home/tux/.gem/ruby/2.6.0'
require 'vecmath'

PALETTE = %w[#0F4155 #158CA7 #D63826 #F5C03E #152A3B #7EC873 #4B3331].freeze


  # create a java primitive array of signed int
  #  @cols = web_array(PALETTE)
  @group = ColorGroup.from_web_array(PALETTE)
  @colors = @group.colors
  stroke_cap SQUARE
  stroke(0, 200)
  @coloured = true


def draw
  arc_pattern
  no_loop
end

def sep_index(idx, length)
  (idx - (length - 1) * 0.5).abs.floor
end

def sep_color(idx, number)
  @colors[sep_index(idx - 1, number + 1)]
end

def arc_pattern
  circ_number = rand(4..10)
  block_size = rand(30..70)
  back_color = @coloured ? @group.last : 255
  fill(back_color)
  rect(0, 0, width, height)
  half_block = block_size / 2
  two_block = 2 * block_size
  MathTool::grid(width + two_block, height + two_block, block_size, block_size) do |x, y|
    push_matrix
    translate x, y
    rotate HALF_PI * rand(0..4)
    circ_number.downto(0) do |i|
      diam = two_block * i / (circ_number + 1)
      ccolor = i < 2 || !coloured ? back_color : sep_color(i, circ_number)
      fill ccolor
      arc(-half_block, -half_block, diam, diam, 0, HALF_PI)
      arc(half_block, half_block, diam, diam, PI, PI + HALF_PI)
    end
    pop_matrix
  end
end

```
