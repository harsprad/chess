Dir['lib/pieces/*.rb'].each do |f| 
  require_relative '.' + f.delete_prefix('lib')
end

class ChessBoard
  def initialize
    set_up_board
    @history = []
    @turn = :white
  end

  def move(from, to)
    from_row, from_col = from
    to_row, to_col = to

    piece = @board[from_row][from_col]
    raise("no piece at target square") if piece.nil?

    available = piece.available_moves(@board)
    raise("invalid move") unless available.include?(to)

    legal = legalify_moves(available)
    raise("illegal move") unless legal.include?(to)

    @board[to_row][to_col] = piece
    @board[from_row][from_col] = nil

    @history << [from, to]
    @turn = (@turn == :white) ? :black : :white
  end

  def legalify_moves(move_list)
    #TODO
    # list will be format Array of Array where each sub array goes along the path diagonal or straight or both (queen)
    # this method will take each sub array and cut off the ends so as to find the limit of the piece movement along each axis. Then filter out moves which will result in a checkmate
    move_list.flatten
  end

  def set_up_board
    @board = Array.new(8) { Array.new(8) }
    [0, 7].each do |i|
      colour = (i == 7) ? :white : :black
      @board[i][0] = Rook.new(colour)
      @board[i][1] = Knight.new(colour)
      @board[i][2] = Bishop.new(colour)
      @board[i][3] = Queen.new(colour)
      @board[i][4] = King.new(colour)
      @board[i][5] = Bishop.new(colour)
      @board[i][6] = Knight.new(colour)
      @board[i][7] = Rook.new(colour)
    end

    (0..7).each do |i|
      @board[6][i] = Pawn.new(:white)
      @board[1][i] = Pawn.new(:black)
    end
  end

end
