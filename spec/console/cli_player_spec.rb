require "rspec"
require "console/cli_player"

RSpec.describe CliPlayer do
  it "accepts correct input and parses it" do
    input = StringIO.new("1")
    output = StringIO.new
    player = CliPlayer.new("X", output, input)

    valid_move = player.get_move(Board.new(3))

    expect(valid_move).to eql(1)
  end

  it "prompts for input again if the format is incorrect" do
    input = StringIO.new("afsfasdfsd\n1")
    output = StringIO.new
    player = CliPlayer.new("X", output, input)

    valid_move = player.get_move(Board.new(3))

    expect(valid_move).to eql(1)
  end

  it "prompts for input again if the tile is already taken" do
    output = StringIO.new
    input = StringIO.new("1\n4")
    player = CliPlayer.new("X", output, input)
    opponent = Machine.new("O")
    board = Board.new(3)
    board.check_tile(1, opponent)

    move = player.get_move(board)

    expect(move).to eql(4)
  end

  it "makes a move in the board given some input" do
    input = StringIO.new("1")
    output = StringIO.new
    player = CliPlayer.new("X", output, input)
    board = Board.new(3)
    player.make_move(board)

    expect(board.tile(1)).to eql(player.symbol)
  end
end
