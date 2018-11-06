require "rspec"
require "core/player"
require "core/board"

RSpec.describe Player do
  it "Raises an error if get_move is used" do
    player = Player.new("X")

    expect{player.get_move(Board.new(3))}.to raise_error(NotImplementedError)
  end

  it "is equal to another player with the same symbol" do
    expect(Player.new("X") == Player.new("X")).to eql(true)
  end

  it "is not equal to another player with a different symbol" do
    expect(Player.new("X") == Player.new("O")).to eql(false)
  end

  it "is not equal to another player with a different symbol (!= operator)" do
    expect(Player.new("X") != Player.new("O")).to eql(true)
  end

  it "is equal to another player with the same symbol (!= operator)" do
    expect(Player.new("X") != Player.new("X")).to eql(false)
  end
end
