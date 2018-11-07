require "console/game_factory"
require "console/console_io"

class Console
  attr_accessor :game

  def initialize(io)
    @io = io
  end

  def play
    setup_game
    until @game.ended?
      process_turn
    end
    @io.print_results(@game)
    restart
  end

  def setup_game
    factory = GameFactory.new
    @io.print_menu

    options = @io.get_menu_option
    @game = factory.create_game(options)

    @io.print_board(@game.board)
  end

  def process_turn
    @game.make_move
    @io.print_board(@game.board)
  end

  def restart
    option = @io.get_restart_option
    if(option == RestartOptions::YES)
      play
    end
  end
end
