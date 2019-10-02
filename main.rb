# frozen_string_literal: true

require 'gosu'
require 'geometry'
require_relative 'polygon'

class GameWindow < Gosu::Window
  def initialize
    super 1920, 1080

    # TODO: create polygon yourself
    @pentagon = Polygon.new(7, [960, 540], 200)
  end

  def button_down(btn)
    if btn == Gosu::KB_ESCAPE
      close
    elsif btn == Gosu::KB_D
      p @pentagon
    end
  end

  def update
    @pentagon.translate if button_down?(Gosu::KB_UP)
    @pentagon.rotate(false) if button_down?(Gosu::KB_RIGHT)
    @pentagon.rotate(true) if button_down?(Gosu::KB_LEFT)
  end

  def draw
    @pentagon.draw(self)
  end
end

window = GameWindow.new
window.show
