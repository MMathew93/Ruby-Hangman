# frozen_string_literal: true

require_relative 'game'

def startgame
  game = Game.new
  game.start
end

startgame
