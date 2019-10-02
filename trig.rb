# frozen_string_literal: true

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

  def self.rotation_coord_transform(radius, angle)
    [radius * Math.sin(to_rad(angle)),
     radius * Math.cos(to_rad(angle))]
  end
end
