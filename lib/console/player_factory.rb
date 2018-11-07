require "console/cli_player"
require "core/machine"
require "core/hard_machine"

module PlayerOptions
  MACHINE = "Machine"
  HARD_MACHINE = "HardMachine"
  HUMAN = "Human"
end

class PlayerFactory
  def create_player(type, symbol)
    case type
    when PlayerOptions::HUMAN
      CliPlayer.new(symbol)
    when PlayerOptions::MACHINE
      Machine.new(symbol)
    when PlayerOptions::HARD_MACHINE
      HardMachine.new(symbol)
    else
      raise NotImplementedError.
        new("#{type}# is not a valid type of player.")
    end
  end
end
