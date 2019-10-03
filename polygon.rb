# frozen_string_literal: true

require 'gosu'
require_relative 'trig'


# create and manipulate polygons in a 2D space
class Polygon
  SPEED = 10
  TORQUE = 5

  def initialize(sides, center, radius)
    @points = []
    @center = center
    @radius = radius
    @sides = sides
    generate
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
      transform = Trig.rotation_coord_transform(@radius, angle, @center)
      point[0] = transform[0]
      point[1] = transform[1]
    end
  end

  def draw(window, colour)
    @points.each_with_index do |point, i|
      next_point = @points[(i + 1).modulo(@sides)]
      window.draw_line(point[0], point[1], colour, next_point[0], next_point[1], colour)
    end
    window.draw_line(@points.first[0], @points.first[1], colour, @center[0], @center[1], colour)
  end

  private

  def generate
    angle = 0
    increment = 360 / @sides

    @sides.times do
      @points << Trig.rotation_coord_transform(@radius, angle, @center)
      angle += increment
    end
  end
end
