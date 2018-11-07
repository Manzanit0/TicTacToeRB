require "core/board"
require "core/player"

class HardMachine < Player
  # Depth is tracked in order to be able to identify quicker wins.
  # A value 1 means a win in one turn.
  INITIAL_DEPTH = 0

  def initialize(symbol)
    super(symbol)
    @opponent = Player.new(symbol == "X" ? "O" : "X")
  end

  def get_move(board)
    @current_player = self # We need to keep track of turns since HardMachine class simulates a game.
    minimax(board, INITIAL_DEPTH)
    @choice
  end

  def minimax(board, depth)
    return score(board, depth) if (board.complete? || board.won?(self) || board.won?(@opponent))
    depth += 1
    scores, moves = [], []

    board.available_tiles.each do |tile|
      new_board = create_board_with_new_state(board, tile)
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
      0 # In case it's a draw.
    end
  end

  private

  def toggle_player
    @current_player = @current_player == self ? @opponent : self
  end

  def create_board_with_new_state(board, move)
    new_board = board.clone
    new_board.mark_tile(move, @current_player)
    new_board
  end
end
