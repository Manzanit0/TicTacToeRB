class Board
  UNCHECKED_TILE = ' '

  attr_reader :size

  def initialize(size)
    @size = size
    @simplified_board = Array.new(size*size, UNCHECKED_TILE)
  end

  # This method simply parses the row/column input to a list-like one. Only for refactoring purposes.
  def to_list_input(row, column)
    (row*3 + column)
  end

  def tile(*args)
    case args.size
    when 1
      position = args[0]
      @simplified_board[position]
    when 2
      row, column = args[0], args[1]
      @simplified_board[to_list_input(row, column)]
    else
      raise ArgumentError.new("wrong amount of arguments")
    end
  end

  def row(index)
    @simplified_board.each_slice(3).to_a[index]
  end

  def column(index)
    @simplified_board.each_slice(3).to_a.transpose[index]
  end

  def diagonal
    tiles = []
    position = 0
    until position > (size*size - 1) # In a 3x3 board, that would be 8 due to 0-based indexes.
      tiles << @simplified_board[position]
      position = position + @size + 1
    end
    tiles
  end

  def anti_diagonal
    tiles = []
    position = @size - 1
    until position > (@size*@size - @size)
      tiles << @simplified_board[position]
      position = position + (@size - 1)
    end
    tiles
  end

  def available_tiles
   @simplified_board.each_index.select { |index| @simplified_board[index] == UNCHECKED_TILE}
  end

  def check_tile(*args)
    case args.size
    when 2
      position, player = args[0], args[1]
      @simplified_board[position] = player.symbol
    when 3
      row, column, player = args[0], args[1], args[2]
      @simplified_board[to_list_input(row, column)] = player.symbol
    else
      raise ArgumentError.new("wrong amount of arguments")
    end
  end

  def is_board_complete?
    @simplified_board.does_not_include?(UNCHECKED_TILE)
  end

  def is_free?(position)
    @simplified_board[position] == UNCHECKED_TILE
  end

  def has_won?(player)
    return true if diagonal.all? { |tile| tile == player.symbol }
    return true if anti_diagonal.all? { |tile| tile == player.symbol }

    (0...@size).each do |index|
      return true if column(index).all? { |tile| tile == player.symbol }
      return true if row(index).all? { |tile| tile == player.symbol }
    end
    false
  end
end

module Enumerable
  def does_not_include?(item)
    !include?(item)
  end
end
