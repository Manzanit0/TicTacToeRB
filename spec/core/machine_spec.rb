require "rspec"
require "core/board"
require "core/machine"

RSpec.describe Machine do
  it "Initializes with a symbol" do
    player = Machine.new("X")
    expect(player.symbol).to eql("X")
  end

  it "Gets the first availiable tile in the board" do
    board = Board.new(3)
    player = Machine.new("X")
    move = player.get_move(board)

    expect(move).to eql(0)
  end

  it "Gets the second availiable tile in the board" do
    board = Board.new(3)
    player1 = Machine.new("O")
    board.mark_tile(0, player1)
    move = player1.get_move(board)

    expect(move).to eql(1)
  end
end
