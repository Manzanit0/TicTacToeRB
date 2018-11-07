require "console/console_io"
require "core/board"
require "core/game"
require "core/player"

RSpec.describe ConsoleIO do
  it "displays the menu with all options" do
    MENU = <<~HEREDOC
      \e[H\e[2J
      --- GAME MODES ---
      1. Human vs Human
      2. Human vs Computer
      3. Computer vs Human
      4. Computer vs Computer

      -- Hard Mode  --
      5. Human vs Computer
      6. Computer vs Human
      7. Computer vs Computer
    HEREDOC

    output = StringIO.new
    io = ConsoleIO.new(output)

    io.print_menu

    expect(output.string).to eql(MENU)
  end

  it "prints the board with correct formatting" do
    EMPTY_BOARD = <<~HEREDOC
      \e[H\e[2J
      _____________
      |   |   |   | 
      _____________
      |   |   |   | 
      _____________
      |   |   |   | 
      _____________
    HEREDOC

    output = StringIO.new
    io = ConsoleIO.new(output)

    io.print_board(Board.new(3))

    expect(output.string).to eql(EMPTY_BOARD)
  end

  it "prints a row with its marked tiles" do
    EXPECTED_ROW = "| X |   | O | "
    player1 = Player.new("X")
    player2 = Player.new("O")
    game = Game.new(player2, player2)
    game.board.mark_tile(3, player1)
    game.board.mark_tile(5, player2)
    
    output = StringIO.new
    io = ConsoleIO.new(output)

    io.print_row(game.board, 1)

    expect(output.string).to eql(EXPECTED_ROW)
  end

  it "prints a winner if there is one" do
    EXPECTED_WINNER_MSG = "The winner is X\n"
    player1 = Player.new("X")
    player2 = Player.new("O")
    game = Game.new(player1, player2)
    game.board.mark_tile(3, player1)
    game.board.mark_tile(4, player1)
    game.board.mark_tile(5, player1)
    
    output = StringIO.new
    io = ConsoleIO.new(output)

    io.print_results(game)

    expect(game.winner).to eql(player1)
    expect(output.string).to eql(EXPECTED_WINNER_MSG)
  end

  it "gets the game mode option from user input" do
    input = StringIO.new("1")
    output = StringIO.new
    io = ConsoleIO.new(output, input)

    expect(io.get_menu_option).to eql("1")
  end

  it "prompts the user for a menu option until the input is right" do
    input = StringIO.new("g\n1")
    output = StringIO.new
    io = ConsoleIO.new(output, input)

    expect(io.get_menu_option).to eql("1")
  end

  it "prompts the user for a restart option until the input is right" do
    input = StringIO.new("g\n1\nY")
    output = StringIO.new
    io = ConsoleIO.new(output, input)
    
    expect(io.get_restart_option).to eql("Y")
  end
end
