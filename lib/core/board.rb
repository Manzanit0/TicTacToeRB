class Board
  UNCHECKED_TILE = ' '

  attr_reader :size

  def initialize(size)
    @size = size
    @board = []

    (0...size).each do |i|
      @board[i] = []
      (0...size).each do
        @board[i] << UNCHECKED_TILE
      end
    end

    # NEW IMPLEMENTATION
    @simplified_board = Array.new(size*size, UNCHECKED_TILE)
  end

  # This method simply parses the row/column input to a list-like one. Only for refactoring purposes.
  def to_list_input(row, column)
    (row*3 + column)
  end

  def tile(row, column)
    @board[row][column]

    # NEW IMPLEMENTATION
    @simplified_board[to_list_input(row, column)]
  end

  def row(index)
    @simplified_board.each_slice(3).to_a.transpose[index]
  end

  def column(column)
    tiles = []
    @board.each do |row|
      tiles << row[column]
    end
    tiles

    # NEW IMPLEMENTATION
    @simplified_board.each_slice(3).to_a.transpose[column]
  end

  def diagonal
    tiles = []
    i = 0
    @board.each do |row|
      tiles << row[i]
      i+=1
    end
    tiles

    # NEW IMPLEMENTATION
    tiles = []
    position = 0
    until position > (size*size - 1) # In a 3x3 board, that would be 8 due to 0-based indexes.
      tiles << @simplified_board[position]
      position = position + size + 1
    end
    tiles
  end

  def anti_diagonal
    tiles = []
    i = @size - 1
    @board.each do |row|
      tiles << row[i]
      i-=1
    end
    tiles

    # NEW IMPLEMENTATION
    tiles = []
    position = size - 1
    until position > (size*size - 1)
      tiles << @simplified_board[position]
      position = position + (size - 1)
    end
    tiles
  end

  def check_tile(row, column, player)
    @board[row][column] = player.symbol

    # NEW IMPLEMENTATION
    @simplified_board[to_list_input(row, column)] = player.symbol
  end

  def is_board_complete?
    @board.each do |row|
      row.each do |tile|
        return false unless tile != UNCHECKED_TILE
      end
    end
    true

    # NEW IMPLEMENTATION
    @simplified_board.does_not_include?(UNCHECKED_TILE)
  end

  def is_free?(move)
    @board[move[0]][move[1]] == UNCHECKED_TILE

    # NEW IMPLEMENTATION
    @simplified_board[to_list_input(move[0], move[1])] == UNCHECKED_TILE
  end

  def has_won?(player)
    column_win, row_win, diagonal_win, anti_diagonal_win = true, true, true, true

    (0...@size).each do |row|
      (0...@size).each do |column|
        row_win = false if @board[row][column] != player.symbol
        column_win = false if @board[column][row] != player.symbol
        diagonal_win = false if row == column && @board[row][column] != player.symbol
        anti_diagonal_win = false if @board[row][@size-1-row] != player.symbol
      end

      return true if (
        row_win ||
        column_win ||
        (diagonal_win && (row == @size - 1)) ||
        (anti_diagonal_win && (row == @size - 1))
      )

      column_win, row_win = true, true
    end

    false

    # NEW IMPLEMENTATION
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
