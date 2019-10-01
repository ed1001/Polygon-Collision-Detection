# frozen_string_literal: true

require 'gosu'
require 'geometry'

class Polygon
  SPEED = 3
  TORQUE = 4

  def initialize(sides, center, radius)
    template = Geometry::RegularPolygon.new(sides: sides, center: center, radius: radius)
    @points = template.points
    @center = template.center
    @radius = radius
    @sides = sides
  end

  def translate
    delta = @points[0].zip(@center).map { |pair| (pair.reduce(&:-) / r).to_f }

    @points.each do |point|
      point[0] += delta[0]
      point[1] += delta[1]
    end
  end

  def draw(window)
    @points.each_with_index do |point, i|
      next_point = @points[(i + 1).modulo(@sides)]
      window.draw_line(point[0], point[1], Gosu::Color::BLUE, next_point[0], next_point[1], Gosu::Color::BLUE)
    end
    window.draw_line(@points.first[0], @points.first[1], Gosu::Color::BLUE, @center[0], @center[1], Gosu::Color::BLUE)
  end
end

  # def translate_polygon(polygon)
  #   r = polygon.radius
  #   factors = polygon.points[1].zip(polygon.center).map { |union| (union.reduce(&:-) / r).to_f  }
  #   x = polygon.center[0]
  #   y = polygon.center[1]
  #   Geometry::RegularPolygon.new sides: 5, center: [x + factors[0], y + factors[1]], diameter: 200
  # end

  # def rotate_right_polygon(polygon)
  #   p polygon.points
  #   polygon.points.each do |point|
  #     point[0] = point[0] + (polygon.radius * Math.sin(TORQUE * Math::PI / 180)) + 1
  #     point[1] = point[1] - polygon.radius * (1 - Math.cos(TORQUE * Math::PI / 180))
  #   end
  #   p polygon.points
  #   polygon
  # end
