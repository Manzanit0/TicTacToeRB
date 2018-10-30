class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def make_move(board)
    move = get_move(board) # Machine class returns position, CLI returns matrix.

    if (move.is_a? Enumerable)
      board.check_tile(move[0], move[1], self)
    else
      board.check_tile(move, self)
    end
  end

  def get_move(board)
    raise NotImplementedError.
            new("#{self.class.name}# has not implemented the method get_move")
  end
end
