require 'byebug'

class Piece
  attr_reader :board, :position, :color
  attr_writer :color

  def initialize(position, board, color)
    @position =  position
    @board = board
    @color = color
  end

end

class SlidingPieces < Piece

  def moves
    results = []

    self.class::MOVES.each do |k, v|
      current_pos = [position[0] + v[0], position[1] + v[1]]

      while Board.in_bounds?(current_pos) && (board[current_pos].nil? || board[current_pos].color != self.color)
        results << current_pos
        break if !board[current_pos].nil?
        current_pos = [current_pos[0] + v[0], current_pos[1] + v[1]]

      end
      current_pos = position
    end

  results
  end

end

class Bishop < SlidingPieces
  MOVES = {
    upleft: [-1, -1],
    upright: [-1, 1],
    downleft: [1, -1],
    downright: [1, 1]
  }





end

class Queen < SlidingPieces
  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0],
    upleft: [-1, -1],
    upright: [-1, 1],
    downleft: [1, -1],
    downright: [1, 1]
  }

end

class Rook < SlidingPieces

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

end

class SteppingPieces < Piece

  def moves
    # debugger
    results = []

    self.class::MOVES.each do |k, v|
      current_pos = [position[0] + v[0], position[1] + v[1]]

      if Board.in_bounds?(current_pos) && (board[current_pos].nil? || board[current_pos].color != self.color)
        results << current_pos
      end
      current_pos = position
    end

  results
  end
end

class King < SteppingPieces
  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0],
    upleft: [-1, -1],
    upright: [-1, 1],
    downleft: [1, -1],
    downright: [1, 1]
  }
end

class Knight < SteppingPieces

  MOVES = {
    NNW: [-2, -1],
    NNE: [-2, 1],
    NWW: [-1, -2],
    NEE: [-1, 2],
    SSW: [2, -1],
    SSE: [2, 1],
    SEE: [1, 2],
    SWW: [1, -2]
  }

end

class Pawn < Piece
  MOVES = {
    :w => {:moving => [[-1,0]], :two_space_move => [[-2,0]], :attacking => [[-1,-1],[-1,1]]},
    :b => {:moving => [[1,0]], :two_space_move => [[2,0]], :attacking => [[1,-1],[1,1]] }
  }

  def apply_deltas
    result = Hash.new {|h,k| h[k] = [] }

    modes = self.class::MOVES[self.color]
    modes.each do |key, value|
      value.each do |delta|
        current_pos = [position[0] + delta[0], position[1] + delta[1]]
        result[key] << current_pos if Board.in_bounds?(current_pos)
      end
    end

    result
  end

  def moves
    results = []
    apply_deltas[:moving].each do |new_pos|
      results << new_pos if board[new_pos].nil?
    end
    apply_deltas[:two_space_move].each do |new_pos|
      results << new_pos if board[new_pos].nil? && self.unmoved?
    end
    apply_deltas[:attacking].each do |new_pos|
      results << new_pos if !board[new_pos].nil? && board[new_pos].color != color
    end

    results
  end

  def unmoved?
    return true if self.color == :w && self.position[0] == 6
    return true if self.color == :b && self.position[0] == 1
    false
  end

end

# load "./lib/display.rb"
# load "./lib/pieces.rb"
# b = Board.new
# p1 = Pawn.new([4,0],b,:w)
# p2 = Pawn.new([3,1],b,:b)
# b[[4,0]] = p1
# b[[3,1]] = p2
