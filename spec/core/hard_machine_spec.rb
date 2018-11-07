require "rspec"
require "core/game"
require "core/board"
require "core/hard_machine"

RSpec.describe HardMachine do
  it "chooses a winning move when it has the occasion" do
    move = get_best_move([
      "X", " ", "X",
      " ", "O", " ",
      " ", " ", "O"
    ])

    expect(move).to eql(1)
  end

  it "chooses a winning move when it has the occasion (II)" do
    move = get_best_move([
      "X", " ", " ",
      " ", "O", " ",
      "X", " ", "O"
    ])

    expect(move).to eql(3)
  end

  it "chooses a blocking move when the opponent is going to win in the following turn" do
    move = get_best_move([
      " ", " ", "X",
      " ", "O", " ",
      "X", " ", "O"
    ])

    expect(move).to eql(0)
  end

  it "chooses a blocking move when the opponent is going to win in the following turn (II)" do
    move = get_best_move([
      " ", " ", "X",
      "X", " ", "O",
      "O", " ", "O"
    ])

    expect(move).to eql(7)
  end

  it "draws a game against another HardMachine" do
    player1 = HardMachine.new("X")
    player2 = HardMachine.new("O")
    game = Game.new(player1, player2)

    play_game(game)

    expect(game.ended?).to eql(true)
    expect(game.winner).to eql(nil)
  end

  it "wins a game against another HardMachine which has made a mistake" do
    player1 = HardMachine.new("X")
    player2 = HardMachine.new("O")
    game = Game.new(player1, player2)
    game.board = Board.create_from_array([
      "X", " ", " ",
      "O", " ", " ",
      " ", " ", " "
    ])

    play_game(game)

    expect(game.ended?).to eql(true)
    expect(game.winner).to eql(player1)
  end

  def get_best_move(game_status)
    board = Board.create_from_array(game_status)
    player = HardMachine.new("X")
    player.get_move(board)
  end

  def play_game(game)
    game.make_move until game.ended?
  end
end
