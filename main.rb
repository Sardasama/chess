require_relative 'lib/board'
require_relative 'lib/chesspieces'
require_relative 'lib/game'

mygame = Game.new
mygame.debugmode = false
mygame.start
