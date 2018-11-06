require "core/board"

class Game
  attr_accessor :board, :current_player

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @board = Board.new(3) # ATM, hardcoded. Down the road, we inject it.
  end

  def make_move
    @current_player.make_move(@board)
    toggle_player
  end

  def toggle_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def has_ended?
    @board.complete? || @board.has_won?(@player1) || @board.has_won?(@player2)
  end

  def winner
    return @player1 if @board.has_won?(@player1)
    return @player2 if @board.has_won?(@player2)
    nil
  end
end
