require 'gosu'
require 'geometry'



class GameWindow < Gosu::Window
  def initialize
    super 1920, 1080

    @pentagon = Geometry::RegularPolygon.new sides:5, center:[500,200], diameter:200
  end

  def button_down(btn)
    if btn == Gosu::KB_ESCAPE
      close
    elsif btn == Gosu::KB_D
      p @pentagon
    end
  end

  def update
    @pentagon = translate_polygon(@pentagon) if button_down?(Gosu::KB_UP)
    @pentagon = rotate_right_polygon(@pentagon) if button_down?(Gosu::KB_RIGHT)
  end

  def draw
    draw_polygon(@pentagon)
  end

  private

  def draw_polygon(polygon)
    polygon.points.each_with_index do |point, i|
      next_point = polygon.points[(i + 1).modulo(polygon.points.length)]
      draw_line(point[0], point[1], Gosu::Color::BLUE, next_point[0], next_point[1], Gosu::Color::BLUE)
    end
    draw_line(polygon.points.first[0], polygon.points.first[1], Gosu::Color::BLUE, polygon.center[0], polygon.center[1], Gosu::Color::BLUE)
  end

  def translate_polygon(polygon)
    r = polygon.radius
    factors = polygon.points[1].zip(polygon.center).map { |union| (union.reduce(&:-) / r).to_f  }
    x = polygon.center[0]
    y = polygon.center[1]
    Geometry::RegularPolygon.new sides:5, center:[x + factors[0], y + factors[1]], diameter:200
  end
end

window = GameWindow.new
window.show


# xP2=xP1+rsinθ;
# yP2=yP1−r(1−cosθ)

# x + (radius * Math.sin(angle))
# y - radius * (1 - Math.cos(angle))
