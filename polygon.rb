# frozen_string_literal: true

require 'gosu'
require 'geometry'

class Polygon
  SPEED = 10
  TORQUE = 4

  def initialize(sides, center, radius)
    template = Geometry::RegularPolygon.new(sides: sides, center: center, radius: radius)
    @points = template.points
    @center = template.center
    @radius = radius
    @sides = sides
  end

  def translate
    delta = @points[0].zip(@center).map { |pair| (pair.reduce(&:-) / @radius).to_f }

    @points.each do |point|
      point[0] += delta[0] * SPEED
      point[1] += delta[1] * SPEED
    end
    @center[0] += delta[0] * SPEED
    @center[0] += delta[1] * SPEED
  end

  # def rotate(clockwise)
  #   @points.each do |point|
  #     point[0] = point[0] + (@radius * Math.sin(TORQUE * Math::PI / 180))
  #     point[1] = point[1] - @radius * (1 - Math.cos(TORQUE * Math::PI / 180))
  #   end
  # end

  def draw(window)
    @points.each_with_index do |point, i|
      next_point = @points[(i + 1).modulo(@sides)]
      window.draw_line(point[0], point[1], Gosu::Color::BLUE, next_point[0], next_point[1], Gosu::Color::BLUE)
    end
    window.draw_line(@points.first[0], @points.first[1], Gosu::Color::BLUE, @center[0], @center[1], Gosu::Color::BLUE)
  end
end
