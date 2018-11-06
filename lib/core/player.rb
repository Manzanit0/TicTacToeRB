class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def make_move(board)
    move = get_move(board)
    board.check_tile(move, self)
  end

  def get_move(board)
    raise NotImplementedError.
            new("#{self.class.name}# has not implemented the method get_move")
  end

  def ==(other)
    return false if other == nil
    @symbol == other.symbol
  end

  def !=(other)
    return false if other == nil
    @symbol != other.symbol
  end
end
