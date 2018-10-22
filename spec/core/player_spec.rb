require 'rspec'
require 'spec_helper'
require 'core/player'
require 'core/board'

RSpec.describe Player do
  it "Initializes with a symbol" do
    player = Player.new('X')
    expect(player.symbol).to eql('X')
  end

  it "Checks a specified tile in the board" do
    board = Board.new(3)
    player = Player.new('X')
    player.make_move(board, 0, 0)
    expect(board.tile(0, 0)).to eql('X')
  end
end