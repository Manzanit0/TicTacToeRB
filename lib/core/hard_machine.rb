require "core/board"
require "core/player"

# HardMachine class follows the minmax algorithm to choose the next move.
# The algorithm has been implemented taking into account depth in order
# to be able to identify quicker wins over longer ones.
class HardMachine < Player
  INITIAL_DEPTH = 0

  def initialize(symbol)
    super(symbol)
    @opponent = Player.new(symbol == "X" ? "O" : "X")
  end

  def get_move(board)
    @current_player = self
    minimax(board, INITIAL_DEPTH)
    @choice
  end

  private

  def minimax(board, depth)
    return score(board, depth) if board.complete? || board.won?(self) || board.won?(@opponent)

    depth += 1
    scores, moves = [], []

    board.available_tiles.each do |tile|
      new_board = board.clone_with_new_state(tile, @current_player)
      toggle_player # Swap turn state before entering a new turn simulation.
      scores << minimax(new_board, depth)
      moves << tile
      toggle_player # Upon end, the function has to return to the previous player's turn.
    end

    if @current_player == self
      max_score_index = scores.each_with_index.max[1]
      @choice = moves[max_score_index]
      scores[max_score_index]
    else
      min_score_index = scores.each_with_index.min[1]
      @choice = moves[min_score_index]
      scores[min_score_index]
    end
  end

  def score(board, depth)
    if board.won?(self)
      10 - depth
    elsif board.won?(@opponent)
      depth - 10
    else
      0
    end
  end

  def toggle_player
    @current_player = @current_player == self ? @opponent : self
  end
end
