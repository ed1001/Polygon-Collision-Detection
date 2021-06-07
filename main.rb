# frozen_string_literal: true

require 'gosu'
require_relative 'polygon'

class GameWindow < Gosu::Window
  def initialize
    super 1920, 1080

    @poly_a = Polygon.new(4, [1100, 540], 200)
    @poly_b = Polygon.new(4, [300, 540], 200)
  end

  def button_down(btn)
    if btn == Gosu::KB_ESCAPE
      close
    elsif btn == Gosu::KB_G
      @poly_a = Polygon.new(rand(3..8), [1100, 540], 200)
      @poly_b = Polygon.new(rand(3..8), [300, 540], 200)
    elsif btn == Gosu::KB_D
      # DEBUG
      puts 'polygon A:'
      p @poly_a
      puts 'polygon B:'
      p @poly_b
    end
  end

  def update
    @poly_a.translate if button_down?(Gosu::KB_UP)
    @poly_a.rotate(false) if button_down?(Gosu::KB_RIGHT)
    @poly_a.rotate(true) if button_down?(Gosu::KB_LEFT)

    @poly_b.translate if button_down?(Gosu::KB_W)
    @poly_b.rotate(false) if button_down?(Gosu::KB_S)
    @poly_b.rotate(true) if button_down?(Gosu::KB_A)

    Polygon.check_collision(@poly_a, @poly_b)
  end

  def draw
    @poly_a.draw(self, @poly_a.colour)
    @poly_b.draw(self, @poly_b.colour)
  end
end

window = GameWindow.new
window.show
