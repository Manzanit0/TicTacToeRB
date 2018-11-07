require "console/game_factory"

module RestartOptions
  YES = "Y"
  NO = "n"
end

class ConsoleIO
  def initialize(output = $stdout, input = $stdin)
    @out = output
    @in = input
  end

  def print_results(game)
    @out.puts "The winner is #{game.winner.symbol}" unless game.winner.nil?
  end

  def print_menu
    clear_console
    @out.puts "\n--- GAME MODES ---\n"
    @out.puts "#{GameOptions::HUMAN_VS_HUMAN}. Human vs Human"
    @out.puts "#{GameOptions::HUMAN_VS_MACHINE}. Human vs Computer"
    @out.puts "#{GameOptions::MACHINE_VS_HUMAN}. Computer vs Human"
    @out.puts "#{GameOptions::MACHINE_VS_MACHINE}. Computer vs Computer\n"
    @out.puts "\n-- Hard Mode  --"
    @out.puts "#{GameOptions::HUMAN_VS_HARD_MACHINE}. Human vs Computer\n"
    @out.puts "#{GameOptions::HARD_MACHINE_VS_HUMAN}. Computer vs Human\n"
    @out.puts "#{GameOptions::HARD_MACHINE_VS_HARD_MACHINE}. Computer vs Computer\n"
  end

  def print_row(board, row)
    @out.print "| "
    board.row(row).each do |token|
      @out.print "#{token} | "
    end
  end

  def print_board(board)
    clear_console
    print_line_separator
    (0...board.size).each do |row|
      print_row(board, row)
      print_line_separator
    end
  end

  def clear_console
    @out.print "\e[H\e[2J"
  end

  def print_line_separator
    @out.print "\n_____________\n"
  end

  def get_menu_option
    @out.print "Choose a game mode to begin: "
    regex = Regexp.new("^([
      #{GameOptions::HUMAN_VS_HUMAN}
      #{GameOptions::HUMAN_VS_MACHINE}
      #{GameOptions::MACHINE_VS_HUMAN}
      #{GameOptions::MACHINE_VS_MACHINE}
      #{GameOptions::HUMAN_VS_HARD_MACHINE}
      #{GameOptions::HARD_MACHINE_VS_HUMAN}
      #{GameOptions::HARD_MACHINE_VS_HARD_MACHINE}
    ])$")

    get_valid_input(regex, "The only valid options are [
      #{GameOptions::HUMAN_VS_HUMAN},
      #{GameOptions::HUMAN_VS_MACHINE},
      #{GameOptions::MACHINE_VS_HUMAN},
      #{GameOptions::MACHINE_VS_MACHINE},
      #{GameOptions::HUMAN_VS_HARD_MACHINE},
      #{GameOptions::HARD_MACHINE_VS_HUMAN},
      #{GameOptions::HARD_MACHINE_VS_HARD_MACHINE}
      ]: ")
  end

  def get_restart_option
    @out.print "Would you like to play again? (#{RestartOptions::YES}/#{RestartOptions::NO}) "
    regex = Regexp.new("^([#{RestartOptions::YES}#{RestartOptions::NO}])$")
    get_valid_input(regex, "Please, type '#{RestartOptions::YES}' for yes or '#{RestartOptions::NO}' for no: ")
  end

  def get_valid_input(regex, error_message)
    option = @in.gets.chomp
    until option.match regex
      @out.print error_message
      option = @in.gets.chomp
    end
    option
  end
end
