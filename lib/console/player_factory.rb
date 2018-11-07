require "console/cli_player"
require "core/machine"
require "core/hard_machine"

module PlayerOptions
  Machine = "Machine"
  HardMachine = "HardMachine"
  Human = "Human"
end

class PlayerFactory
  def create_player(type, symbol)
    case type
    when PlayerOptions::Human
      CliPlayer.new(symbol)
    when PlayerOptions::Machine
      Machine.new(symbol)
    when PlayerOptions::HardMachine
      HardMachine.new(symbol)
    else
      raise NotImplementedError.
        new("#{type}# is not a valid type of player.")
    end
  end
end
