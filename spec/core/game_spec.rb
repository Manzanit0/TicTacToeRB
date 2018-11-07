require "rspec"
require "core/game"
require "core/machine"

RSpec.describe Game do
  before(:each) do
    @player1 = Machine.new("X")
    @player2 = Machine.new("O")
    @game = Game.new(@player1, @player2)
  end

  it "Sets a current player when initialized" do
    expect(@game.current_player).to eql(@player1)
  end

  it "Toggle the current player" do
    @game.toggle_player

    expect(@game.current_player).to eql(@player2)
  end

  it "Marks a tile in the board with the current player" do
    @game.make_move

    expect(@game.board.tile(0)).to eql("X")
    expect(@game.current_player.symbol).to eql("O")
  end

  it "Mark the @game as ended if there are no tiles free" do
    for i in 0..8
        @game.board.mark_tile(i, @player1)
    end

    expect(@game.ended?).to eql(true)
  end

  it "Mark the @game as ended if a player has won via ROW" do
    for i in 0..2
      @game.board.mark_tile(i, @player1)
    end

    expect(@game.ended?).to eql(true)
  end

  it "Mark the @game as ended if a player has won via COLUMN" do
    @game.board.mark_tile(6, @player1)
    @game.board.mark_tile(3, @player1)
    @game.board.mark_tile(0, @player1)

    expect(@game.ended?).to eql(true)
  end

  it "Mark the @game as ended if a player has won via DIAGONAL" do
    @game.board.mark_tile(0, @player1)
    @game.board.mark_tile(4, @player1)
    @game.board.mark_tile(8, @player1)

    expect(@game.ended?).to eql(true)
  end

  it "Mark the @game as ended if a player has won via ANTI-DIAGONAL" do
    @game.board.mark_tile(2, @player1)
    @game.board.mark_tile(4, @player1)
    @game.board.mark_tile(6, @player1)

    expect(@game.ended?).to eql(true)
  end

  it "Returns the winning player, if there is one" do
    @game.board.mark_tile(0, @player1)
    @game.board.mark_tile(1, @player1)
    @game.board.mark_tile(2, @player1)

    expect(@game.winner).to eql(@player1)
  end

  it "When calling winner, if there is no winner, it returns nil" do
    expect(@game.winner).to eql(nil)
  end
end
