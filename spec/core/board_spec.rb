require "rspec"
require "core/board"
require "core/machine"

RSpec.describe Board do
  it "populates the board with tiles when an object is created" do
    board = Board.new(3)
    for i in 0..8
      expect(board.tile(i)).to eql(" ")
    end
  end

  it "checks a tile with the player's symbol given the position" do
    player = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(2, player)
    expect(board.tile(2)).to eql("X")
  end

  it "validates if all the tiles are checked given the position" do
    player = Machine.new("X")
    board = Board.new(1)
    board.mark_tile(0, player) # In a 1x1, this is the only tile.
    expect(board.complete?).to eql(true)
  end

  it "gets a column given the position within the matrix" do
    board = Board.new(3)
    column = board.column(2)
    expect(column[0]).to eql(board.tile(1))
    expect(column[1]).to eql(board.tile(4))
    expect(column[2]).to eql(board.tile(7))
  end

  it "gets the diagonal of the board" do
    board = Board.new(3)
    diagonal = board.diagonal
    expect(diagonal[0]).to eql(board.tile(0))
    expect(diagonal[1]).to eql(board.tile(4))
    expect(diagonal[2]).to eql(board.tile(8))
  end

  it "gets the anti-diagonal of the board" do
    board = Board.new(3)
    diagonal = board.anti_diagonal
    expect(diagonal[0]).to eql(board.tile(2))
    expect(diagonal[1]).to eql(board.tile(4))
    expect(diagonal[2]).to eql(board.tile(6))
  end

  it "gets the indexes of all the availiable tiles in the board" do
    board = Board.new(3)
    player = Machine.new("X")
    board.mark_tile(0, player)
    board.mark_tile(1, player)
    expect(board.available_tiles.size).to eql(7)
    expect(board.available_tiles.index(0)).to eql(nil)
    expect(board.available_tiles.index(1)).to eql(nil)
    expect(board.available_tiles.index(5)).to eql(3)
  end

  it "marks the board as finished/won if a player has a whole ROW checked" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(0, player1)
    board.mark_tile(1, player1)
    board.mark_tile(2, player1)
    expect(board.won?(player1)).to eql(true)
  end

  it "marks the board as finished/won if a player has a whole COLUMN checked" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(0, player1)
    board.mark_tile(3, player1)
    board.mark_tile(6, player1)

    expect(board.won?(player1)).to eql(true)
  end

  it "marks board as finished/won if a player has the ANTI-DIAGONAL checked" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(2, player1)
    board.mark_tile(4, player1)
    board.mark_tile(6, player1)

    expect(board.won?(player1)).to eql(true)
  end

  it "marks board as finished/won if a player has the DIAGONAL checked" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(0, player1)
    board.mark_tile(4, player1)
    board.mark_tile(8, player1)

    expect(board.won?(player1)).to eql(true)
  end

  it "doesn't mark a player as won if there is a tile missing in the middle row" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(3, player1)
    board.mark_tile(5, player1)

    expect(board.won?(player1)).to eql(false)
  end

  it "doesn't mark a player as won if there is a tile missing in the last row" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(6, player1)
    board.mark_tile(7, player1)

    expect(board.won?(player1)).to eql(false)
  end

  it "doesn't mark a player as won if there is a tile missing in the first column" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(0, player1)
    board.mark_tile(3, player1)

    expect(board.won?(player1)).to eql(false)
  end

  it "doesn't mark a player as won if there is a tile missing in the last column" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(2, player1)
    board.mark_tile(8, player1)

    expect(board.won?(player1)).to eql(false)
  end

  it "doesn't mark a player as won if there is a tile missing in the diagonal" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(0, player1)
    board.mark_tile(8, player1)

    expect(board.won?(player1)).to eql(false)
  end

  it "doesn't mark a player as won if there is a tile missing in the diagonal (part II)" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(0, player1)
    board.mark_tile(4, player1)

    expect(board.won?(player1)).to eql(false)
  end

  it "doesn't mark a player as won if there is a tile missing in the anti-diagonal" do
    player1 = Machine.new("X")
    board = Board.new(3)
    board.mark_tile(2, player1)
    board.mark_tile(6, player1)

    expect(board.won?(player1)).to eql(false)
  end
end
