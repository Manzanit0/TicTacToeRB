require "core/board"
require "core/player"

# This class follows the first available move strategy:
# it always moves to the first available position in the board.
class Machine < Player
  def initialize(symbol)
    super(symbol)
  end

  def get_move(board)
    board.available_tiles[0]
  end
end
