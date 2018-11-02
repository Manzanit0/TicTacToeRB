require "rspec"
require "core/board"
require "core/hard_machine"

RSpec.describe HardMachine do
  it "chooses a winning move when it has the occasion" do
    board = Board.create_from_array([
      "X", " ", "X",
      " ", "O", " ",
      " ", " ", "O"
    ])
    player = HardMachine.new("X")
    move = player.get_move(board)
    expect(move).to eql(1)
  end

  it "chooses a winning move when it has the occasion, second test" do
    board = Board.create_from_array([
      "X", " ", " ",
      " ", "O", " ",
      "X", " ", "O"
    ])
    player = HardMachine.new("X")
    move = player.get_move(board)
    expect(move).to eql(3)
  end
end
