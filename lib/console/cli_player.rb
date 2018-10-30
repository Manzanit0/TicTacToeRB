require "core/player"

class CliPlayer < Player
  def initialize(symbol, output = $stdout, input = $stdin)
    super(symbol)
    @out = output
    @in = input
  end

  def get_move(board)
    @out.print "\nPlease input your move (row,column): "
    answer = @in.gets.chomp

    until valid_move?(answer, board)
      @out.print "Please input a valid move with the following format (row,column): "
      answer = @in.gets.chomp
    end

    parse_input(answer)
  end

  private
  def parse_input(answer)
    answer.split(",").map { |s| s.to_i }
  end

  def valid_move?(answer, board)
    r = /^([0-2]),([0-2])$/
    answer.match(r) && board.is_free?(parse_input(answer))
  end
end
