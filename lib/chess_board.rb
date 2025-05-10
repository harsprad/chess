Dir['lib/pieces/*.rb'].each do |f| 
  require_relative '.' + f.delete_prefix('lib')
end

class ChessBoard
  def initialize
    set_up_board
  end

  def set_up_board
    @board = Array.new(8) { Array.new(8) }
    [0, 7].each do |i|
      colour = (i == 7) ? 'white' : 'black'
      @board[i][0] = Rook.new(i, 0, colour)
      @board[i][1] = Knight.new(i, 1, colour)
      @board[i][2] = Bishop.new(i, 2, colour)
      @board[i][3] = Queen.new(i, 3, colour)
      @board[i][4] = King.new(i, 4, colour)
      @board[i][5] = Bishop.new(i, 5, colour)
      @board[i][6] = Knight.new(i, 6, colour)
      @board[i][7] = Rook.new(i, 7, colour)
    end

    (0..7).each do |i|
      @board[6][i] = Pawn.new(6, i, 'white')
      @board[1][i] = Pawn.new(1, i, 'black')
    end
  end

end
