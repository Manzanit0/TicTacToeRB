require_relative 'Tile'

class Board
  attr_reader :rows, :columns

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @board = []

    (0...rows).each do |i|
      @board[i] = []
      (0...columns).each do
        @board[i] << Tile.new
      end
    end
  end

  def tile(row, column)
    @board[row][column]
  end

  def row(row)
    @board[row]
  end

  def column(column)
    tiles = []
    @board.each do |row|
      tiles << row[column]
    end
    tiles
  end

  def diagonal
    tiles = []
    i = 0
    @board.each do |row|
      tiles << row[i]
      i+=1
    end
    tiles
  end

  def anti_diagonal
    tiles = []
    i = @columns - 1
    @board.each do |row|
      tiles << row[i]
      i-=1
    end
    tiles
  end

  def check_tile(row, column, player)
    @board[row][column].check(player)
  end

  def is_board_complete?
    @board.each do |row|
      row.each do |tile|
        return false unless tile.is_checked?
      end
    end
    true
  end

  # TODO Refactor logic. Extract duplication.
  def has_won?(player)
    column_win = true
    row_win = true
    #diagonal_win = false

    (0...@rows).each do |row|
      (0...@columns).each do |column|
        row_win = false if @board[row][column].get_check != player.symbol
        column_win = false if @board[column][row].get_check != player.symbol
      end
      return true if (row_win || column_win)
      row_win = true
      column_win = true
    end


    # Row checking
    # @board.each do |row|
    # bingo = true # whole row is checked by the same player.
    #   previous_check = player.symbol
    #   row.each do |tile|
    #     bingo = false if tile.get_check != previous_check
    #   end
    #   return true if bingo
    # end
    #
    # # Column checking
    # i = 0
    # @board.each do
    #   bingo = true
    #   column = column(i)
    #   previous_check = player.symbol
    #   column.each do |tile|
    #     bingo = false if tile.get_check != previous_check
    #   end
    #   return true if bingo
    #   i += 1
    # end
    #
    bingo = true
    diagonal.each do |tile|
     bingo = false if tile.get_check != player.symbol
    end
    return true if bingo

    bingo = true
    anti_diagonal.each do |tile|
     bingo = false if tile.get_check != player.symbol
    end
    return true if bingo

    false
  end
end
