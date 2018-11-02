require "core/board"
require "core/player"

class HardMachine < Player
  def initialize(symbol)
    super(symbol)
  end

  def get_move(board)
    board.available_tiles.each do |index|
      board.check_tile(index, self)
      if(board.has_won?(self))
        board.uncheck_tile(index)
        return index
      end
      board.uncheck_tile(index)
    end
    nil
  end
end
