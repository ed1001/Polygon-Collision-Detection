# frozen_string_literal: true

require 'gosu'
require_relative 'polygon'

class GameWindow < Gosu::Window
  def initialize
    super 1920, 1080

    # TODO: create polygon yourself
    @pentagon = Polygon.new(4, [1100, 540], 200)
    @triangle = Polygon.new(3, [300, 540], 200)
  end

  def button_down(btn)
    if btn == Gosu::KB_ESCAPE
      close
    elsif btn == Gosu::KB_G
      @pentagon = Polygon.new(rand(3..8), [1100, 540], 200)
      @triangle = Polygon.new(rand(3..8), [300, 540], 200)
    elsif btn == Gosu::KB_D
      # DEBUG
      p @pentagon
    end
  end

  def update
    @pentagon.translate if button_down?(Gosu::KB_UP)
    @pentagon.rotate(false) if button_down?(Gosu::KB_RIGHT)
    @pentagon.rotate(true) if button_down?(Gosu::KB_LEFT)

    @triangle.translate if button_down?(Gosu::KB_W)
    @triangle.rotate(false) if button_down?(Gosu::KB_S)
    @triangle.rotate(true) if button_down?(Gosu::KB_A)
  end

  def draw
    @pentagon.draw(self, Gosu::Color::BLUE)
    @triangle.draw(self, Gosu::Color::GREEN)
  end
end

window = GameWindow.new
window.show
