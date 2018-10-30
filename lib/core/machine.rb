require "core/board"
require "core/player"

class Machine < Player
  def initialize(symbol)
    super(symbol)
  end

  def get_move(board)
    board.available_tiles[0] # Always return the first availiable move.
  end
end
