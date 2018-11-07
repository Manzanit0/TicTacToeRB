class Board
  UNCHECKED_TILE = " "

  attr_reader :size
  attr_accessor :board

  def initialize(size)
    @size = size
    @board = Array.new(size*size, UNCHECKED_TILE)
  end

  def self.create_from_array(array)
    instance = Board.new(3)
    instance.board = array.clone
    instance
  end

  def clone
    instance = Board.new(@size)
    instance.board = board.clone
    instance
  end

  def tile(position)
    @board[position]
  end

  def row(index)
    @board.each_slice(3).to_a[index]
  end

  def column(index)
    @board.each_slice(3).to_a.transpose[index]
  end

  def diagonal
    tiles = []
    position = 0
    until position > (size*size - 1) # In a 3x3 board, that would be 8 due to 0-based indexes.
      tiles << @board[position]
      position = position + @size + 1
    end
    tiles
  end

  def anti_diagonal
    tiles = []
    position = @size - 1
    until position > (@size*@size - @size)
      tiles << @board[position]
      position = position + (@size - 1)
    end
    tiles
  end

  def available_tiles
    @board.each_index.select { |index| @board[index] == UNCHECKED_TILE}
  end

  def mark_tile(position, player)
    @board[position] = player.symbol
  end

  def unmark_tile(position)
    @board[position] = UNCHECKED_TILE
  end

  def complete?
    !@board.include?(UNCHECKED_TILE)
  end

  def free_tile?(position)
    @board[position] == UNCHECKED_TILE
  end

  def won?(player)
    return true if diagonal.all? { |tile| tile == player.symbol }
    return true if anti_diagonal.all? { |tile| tile == player.symbol }

    (0...@size).each do |index|
      return true if column(index).all? { |tile| tile == player.symbol }
      return true if row(index).all? { |tile| tile == player.symbol }
    end
    false
  end
end
