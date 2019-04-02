# ===== Default : Default
$LOAD_PATH << File.expand_path('/home/sid/vecmath/lib', __FILE__)
require 'vecmath'

# Duck typing Boundary
class Boundary
  attr_reader :bounds
  def initialize(bounds)
    @bounds = bounds
  end

  def contains?(vec)
    bounds.contains?(vec)
  end

  def centroid
    bounds.centroid
  end
end

# For use with Boundary
class Circle
  attr_reader :centroid, :radius
  def initialize(center, radius)
    @centroid = center
    @radius = radius
  end

  def contains?(vec)
    centroid.dist(vec) < radius
  end
end

# Use to detect whether instances of line intersect
class Line2D
  attr_reader :a, :b
  def initialize(a, b)
    @a = a
    @b = b
  end

  def intersecting?(line)
    denom = (line.b.y - line.a.y) * (b.x - a.x) - (line.b.x - line.a.x) * (b.y - a.y)
    na = (line.b.x - line.a.x) * (a.y - line.a.y) - (line.b.y - line.a.y) * (a.x - line.a.x)
    nb = (b.x - a.x) * (a.y - line.a.y) - (b.y - a.y) * (a.x - line.a.x)
    return false if denom.zero?

    ua = na / denom
    ub = nb / denom
    (ua >= 0.0 && ua <= 1.0 && ub >= 0.0 && ub <= 1.0)
  end
end

# Stores and manipulates the points
class Path
  attr_reader :points, :last, :bounds, :cut, :theta, :delta, :speed, :searches


  def initialize(bounds, speed, delta, history)
    @bounds = bounds
    @speed = speed
    @delta = delta
    @theta = 0
    @points = (0..history).map { bounds.centroid.copy }
    @searches = 0
    @last = Vec2D.new(points.first)
  end

  def grow
    @delta = rand(-0.2..0.2) if rand < 0.1
    if !intersecting?
      move
    else
      search
    end
  end

  def move
    @last = points.first
    points.pop
    @theta += delta
    points.unshift last + Vec2D.new(speed * Math.cos(theta), speed * Math.sin(theta))
    @searches = 0
  end

  def search
    @theta += delta
    points[0] = last + Vec2D.new(speed * Math.cos(theta), speed * Math.sin(theta))
    @searches += 1
  end

  def intersecting?
    return true unless bounds.contains?(first)

    if searches < 100
      one = Line2D.new(points[0], points[1])
      (3...points.length).each do |idx|
        two = Line2D.new(points[idx], points[idx - 1])
        return true if one.intersecting?(two)
      end
    end
    false
  end
end

@lenny = Path.new(
  Boundary.new(Circle.new(Vec2D.new(width / 2, height / 2), 250)),
  10,
  0.03,
  5_000
)
@renderer = GfxRender.new(graphics)

def draw
  background(255)
  50.times { @lenny.grow }
  draw_path(@lenny)
end

def draw_path(points)
  beginShape
  lenny.map { |vec| vec.to_curve_vertex(@renderer) }
  endShape
end
