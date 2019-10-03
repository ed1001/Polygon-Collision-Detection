# frozen_string_literal: true

require 'mathn'

# handy trigonometry methods for conversions
class Trig
  def self.to_rad(degrees)
    degrees / 180.0 * Math::PI
  end

  def self.to_deg(radians)
    radians * 180 / Math::PI
  end

  def self.angle_from_center(center, point, radius)
    dy = point[1] - center[1]
    negative = point[0] < center[0] ? 360 : 0
    (negative - to_deg(Math.acos(dy / radius))).abs
  end

  def self.rotation_coord_transform(radius, angle, center)
    [radius * Math.sin(to_rad(angle)) + center[0],
     radius * Math.cos(to_rad(angle)) + center[1]]
  end
end
