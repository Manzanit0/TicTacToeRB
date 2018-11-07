require "rspec"
require "console/console"

RSpec.describe Console do
  it "initializes the game with user input" do
    input = StringIO.new("1")
    output = StringIO.new
    io = ConsoleIO.new(output, input)
    console = Console.new(io)

    console.setup_game

    expect(console.game).not_to eql(nil)
  end

  it "makes moves until one player has won or it's a draw" do
    input = StringIO.new(GameOptions::MACHINE_VS_MACHINE+"\nn")
    output = StringIO.new
    io = ConsoleIO.new(output, input)
    console = Console.new(io)

    console.play

    expect(console.game.ended?).to eql(true)
  end

  it "restarts the game upon 'Yes' input" do
    input = StringIO.new("#{GameOptions::MACHINE_VS_MACHINE}\nY\n#{GameOptions::MACHINE_VS_MACHINE}\nn")
    output = StringIO.new
    io = ConsoleIO.new(output, input)
    console = Console.new(io)

    console.play

    expect(console.game.ended?).to eql(true)
  end
end
