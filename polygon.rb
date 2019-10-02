# frozen_string_literal: true

require 'gosu'
require 'geometry'
require_relative 'trig'

# create and manipulate polygons in a 2D space
class Polygon
  SPEED = 10
  TORQUE = 5

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
    @center[1] += delta[1] * SPEED
  end

  def rotate(clockwise)
    torque = clockwise ? TORQUE : -TORQUE
    @points.each do |point|
      angle = Trig.angle_from_center(@center, point, @radius) + torque
      transform = Trig.rotation_coord_transform(@radius, angle)
      point[0] = transform[0] + @center[0]
      point[1] = transform[1] + @center[1]
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
