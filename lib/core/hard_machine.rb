require "core/board"
require "core/player"

class HardMachine < Player
  def initialize(symbol)
    super(symbol)
    @opponent = get_opponent
  end

  def get_move(board)
    board.available_tiles.each do |index|
      new_board = create_new_board(board, index, self)
      return index if score(new_board) == 10

      new_board = create_new_board(board, index, @opponent)
      return index if score(new_board) == -10
    end
    nil
  end

  def score(board)
   return 10 if board.has_won?(self)
   return -10 if board.has_won?(@opponent)
  end

  def get_opponent
    Player.new(self.symbol == "X" ? "O" : "X")
  end

  def create_new_board(board, move, player)
    new_board = board.clone
    new_board.check_tile(move, player)
    new_board
  end
end
