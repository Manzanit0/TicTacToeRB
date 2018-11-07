require "rspec"
require "console/cli_player"

RSpec.describe CliPlayer do
  it "accepts correct input and parses it" do
    player = create_test_player("1")

    valid_move = player.get_move(Board.new(3))

    expect(valid_move).to eql(1)
  end

  it "prompts for input again if the format is incorrect" do
    player = create_test_player("afsfasdfsd\n1")

    valid_move = player.get_move(Board.new(3))

    expect(valid_move).to eql(1)
  end

  it "prompts for input again if the tile is already taken" do
    player = create_test_player("1\n4")
    board = Board.create_from_array([" ", "O", " ", " ", " ", " ", " ", " ", " "])

    move = player.get_move(board)

    expect(move).to eql(4)
  end

  it "makes a move in the board given some input" do
    player = create_test_player("1")
    board = Board.new(3)

    player.make_move(board)

    expect(board.tile(1)).to eql(player.symbol)
  end

  def create_test_player(input_mock)
    output = StringIO.new
    input = StringIO.new(input_mock)
    CliPlayer.new("X", output, input)
  end
end
