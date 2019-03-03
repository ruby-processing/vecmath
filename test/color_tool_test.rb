# frozen_string_literal: true
require_relative 'test_helper'

class ColorGroupTest < Minitest::Test

  PALETTE = %w[#FFFFFF #FF0000 #0000FF].freeze
  COLORS = [16777215, 16711680, 255].to_java(:int)

  def test_new
    group = ColorGroup.new(COLORS)
    assert group.kind_of? ColorGroup
  end

  def test_from_web_array
    group = ColorGroup.from_web_array(PALETTE)
    assert group.kind_of? ColorGroup
  end

  def test_ruby_string
    p5array = [16777215, 16711680, 255]
    group = ColorGroup.new(COLORS)
    ruby_string = "%w[#FFFFFF #FF0000 #0000FF]\n"
    result = group.ruby_string
    assert_equal(result, ruby_string)
  end
end
