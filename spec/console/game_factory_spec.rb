require "rspec"
require "console/cli_player"
require "core/machine"
require "core/hard_machine"
require "console/game_factory"

RSpec.describe GameFactory do
  it "Creates a Human vs Human game" do
    factory = GameFactory.new
    game = factory.create_game(GameOptions::HUMAN_VS_HUMAN)

    expect(game.current_player.instance_of?(CliPlayer)).to eql(true)
    game.toggle_player # TODO: This is a smell - Find out if there is a way of checking private variables
    expect(game.current_player.instance_of?(CliPlayer)).to eql(true)
  end

  it "Creates a Human vs Computer game" do
    factory = GameFactory.new
    game = factory.create_game(GameOptions::HUMAN_VS_MACHINE)

    expect(game.current_player.instance_of?(CliPlayer)).to eql(true)
    game.toggle_player
    expect(game.current_player.instance_of?(Machine)).to eql(true)
  end

  it "Creates a Computer vs Human game" do
    factory = GameFactory.new
    game = factory.create_game(GameOptions::MACHINE_VS_HUMAN)

    expect(game.current_player.instance_of?(Machine)).to eql(true)
    game.toggle_player
    expect(game.current_player.instance_of?(CliPlayer)).to eql(true)
  end

  it "Creates a Computer vs Computer game" do
    factory = GameFactory.new
    game = factory.create_game(GameOptions::MACHINE_VS_MACHINE)

    expect(game.current_player.instance_of?(Machine)).to eql(true)
    game.toggle_player
    expect(game.current_player.instance_of?(Machine)).to eql(true)
  end

  it "Creates a Human vs Hard Computer game" do
    factory = GameFactory.new
    game = factory.create_game(GameOptions::HUMAN_VS_HARD_MACHINE)

    expect(game.current_player.instance_of?(CliPlayer)).to eql(true)
    game.toggle_player
    expect(game.current_player.instance_of?(HardMachine)).to eql(true)
  end

  it "Creates a Hard Computer vs Human game" do
    factory = GameFactory.new
    game = factory.create_game(GameOptions::HARD_MACHINE_VS_HUMAN)

    expect(game.current_player.instance_of?(HardMachine)).to eql(true)
    game.toggle_player
    expect(game.current_player.instance_of?(CliPlayer)).to eql(true)
  end

  it "Creates a Hard Computer vs Hard Computer game" do
    factory = GameFactory.new
    game = factory.create_game(GameOptions::HARD_MACHINE_VS_HARD_MACHINE)

    expect(game.current_player.instance_of?(HardMachine)).to eql(true)
    game.toggle_player
    expect(game.current_player.instance_of?(HardMachine)).to eql(true)
  end

  it "Raises an error if the option is not valid" do
    factory = GameFactory.new
    expect{factory.create_game("69")}.to raise_error(NotImplementedError)
  end
end
